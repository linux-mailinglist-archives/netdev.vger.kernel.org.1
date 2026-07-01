Return-Path: <netdev+bounces-303479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dh0OIeCsRGppywoAu9opvQ
	(envelope-from <netdev+bounces-303479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:00:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D51336EA0F9
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:59:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xzx0XDdn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303479-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303479-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81FEB30E5EA6
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 05:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199D1394793;
	Wed,  1 Jul 2026 05:56:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DBE33C53F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 05:56:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885378; cv=none; b=VFP+fTGY0iMKH4M16vbEL7T2mAUlBHUOpD7iUIyNLwlBaqZL6M5S5TU1A+Vc/GgNstmSfoZ9pXoT8IDW3uSB0omOOytvr3l6DgEvSESi6HKFQ0NRT0+fR5HZ6Hne3aaKal/zhWFtwaKjoKH13IDGUimKjyE/kNiZz7rUn14n5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885378; c=relaxed/simple;
	bh=du69GUw1EIX5aANGYtoDtWVpbMocCveU908JccD8Dt8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=cQ6xbHEjXyiS6lcXk3JTvfLMPkWREE4fGC0iH/zKc4j5Sfq0UfpAgDsIwJAqZuw2uOCaRU9Sx2zCB04bgGRCOHv1fBC5GtnMt0BuuKeV4XZW0rKAe303WTRpkQSxKMxBTF4fjn2i+vYYgVYJutkO4vejqnBVkszsdf9ZlOBiDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xzx0XDdn; arc=none smtp.client-ip=209.85.210.54
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9fa42f08cso269281a34.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782885374; x=1783490174; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMHc6VjC8zpAtFBxLHo9uqSmcB6QkUimxcvK+ODJl3o=;
        b=Xzx0XDdnzBkey9K1juzhg7Occmgf7fcUA4KNpLpW/FRtUI1gHOIRWCZRKKY5aTLfp+
         yTnon9oOc7eddpfQECZVqIKIiWi6M0hgBJyjaCcBcvqHFbDlZdx74RBGKJ16PhMpnpi3
         3D8OZkuZlQPZRmbDbTufJ9ZsWtaX5kXl1meWq2aIXqN/7pwZZ8/FoPpxWBDQwnKH5FHe
         rixh0B26doerafmmBgfiT9sBnYTZPag5f7WoxzwzePOayo/tHRa0rJCP85D19QPmFClW
         EU1CpJgF3MNSVQFrwMgwY0R7dW0MIPUc1bg2Pynaki1tQH2PbAF4RmCURaMAo/MqqIZk
         YuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782885374; x=1783490174;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMHc6VjC8zpAtFBxLHo9uqSmcB6QkUimxcvK+ODJl3o=;
        b=VdbPJUmJoq9yXls3znBfGl1jxzDw91/csdgxbNSNZ3+A4YZrgzLf2L9diTN+dcwExV
         q0U97Qne/yiI//65lt3FJv+bYuwibFTZw+hO9i8bkPAyE+FcbSSN4T+AgFeImGE9wj58
         2NqqjPrbAaLUyJWB92dZFC5ztEqQMesmHTvS6bQZTkBXUBHqEjF3pfBt7g3jFEHMGZ+p
         ZwMBaLwcNrBAUxKgX525C+ZpY/mARzc97j0xXNaDZCnVzESMRUZDYSSItcr0HYHRWC8c
         1UwhZFFRpCdwSKRoH2XomSi/zOTnA2R0EPK6f0AHooFrsT2315SIlnOBzCqimpCALpuV
         61oA==
X-Forwarded-Encrypted: i=1; AFNElJ/BVltUwExzsLtRkJKh0ijDrzm8Er0zsILbEDtc5A3uLTS8Xtuh6BxdljevF6Rz/QYXbx4/vcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjGHonjwOAGK0QWKnEaDaACj91k+0XBTGl4OvoPDvjFq+RUfvB
	sODAktmdznFcyIq9AdrfUckMGA9zdXZN1KrMDsv+pltnvCxnxr6bGEEyynHEgg==
X-Gm-Gg: AfdE7cmqL8hRzKPQMSt317GMduc0yOH5S72O9FLU3x4m2ajcp/2uDsBYw0o2BXydZi7
	gLr6asu7ENYbi8Qgra8Qz52MFbp6vigSqgkp3mrlicma7weS8FlQ3mqtl0PlvZrRBAqDDFbjbIT
	NaiBHimRCFrQg7yUW9XNA+Lnuw6wnySBjk8p6UyOz0uT5qKkBOfjc00PBP8aS7QrSZZ1/jyBznE
	kAUHaxxOmEfMLdY2FnqbMpykbmTdezCYBhcadO79iDhiyn83Bpp+GI5S/IgCKAxxr6jzvdgD/8X
	IkCQcJc+GDnSYrqPMv6gh7VrJZ+h8x31Ne+HdqOk0szxkjSTjWL3xR0u3WIfcf8M967FgVUfL4D
	mxbUxFHweQTg+ZAINF8LR1XcWVviO8RZ6KZ5GCkwmsyMpMDbGjh3hRorm0r0cfbQ82C/8aI5TGe
	SeHFXs6qtWnMW0HTZRuAAyHrigNUbSMCyAYJpNlXym19R7P6Ijn4zmjHVk9QDDyYrOv+OoXiEpc
	K0kMRI=
X-Received: by 2002:a05:6830:81d2:b0:7e9:eaf2:edff with SMTP id 46e09a7af769-7eb4cc4cb36mr45738a34.26.1782885374015;
        Tue, 30 Jun 2026 22:56:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec2e353fsm4114877a34.20.2026.06.30.22.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 22:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 22:56:11 -0700
Message-Id: <DJN048GYRBCZ.M83AO0MXTKSV@gmail.com>
Subject: Re: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "yonghong.song@linux.dev"
 <yonghong.song@linux.dev>, "song@kernel.org" <song@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "memxor@gmail.com" <memxor@gmail.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "horms@kernel.org"
 <horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuniyu@google.com"
 <kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
 <koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
 <g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
 <ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
 <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com"
 <vidhi_goel@apple.com>
X-Mailer: aerc
References: <20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com>
 <DJMRPJEUTY5G.30HYOMPLBGZOJ@gmail.com>
 <PAXPR07MB7984443B70E713F016EAA550A3F62@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984443B70E713F016EAA550A3F62@PAXPR07MB7984.eurprd07.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303479-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:chia-yu.chang@nokia-bell-labs.com,m:jolsa@kernel.org,m:yonghong.song@linux.dev,m:song@kernel.org,m:linux-kselftest@vger.kernel.org,m:memxor@gmail.com,m:shuah@kernel.org,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,kernel.org,linux.dev,vger.kernel.org,gmail.com,iogearbox.net,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D51336EA0F9

On Tue Jun 30, 2026 at 10:46 PM PDT, Chia-Yu Chang (Nokia) wrote:
>> > -     /* override sysctl_tcp_min_tso_segs (optional) */
>> > -     u32 (*min_tso_segs)(struct sock *sk);
>> > +     /*
>> > +      * Override tcp_tso_autosize (optional)
>> > +      *
>> > +      * If provided, this callback returns the final TSO segment numb=
er
>> > +      * and will bypass tcp_tso_autosize() entirely. The implementati=
on
>> > +      * must derive an appropriate value and ensure the result is val=
id.
>> > +      */
>> > +     u32 (*tso_segs)(struct sock *sk, u32 mss_now);
>>=20
>> I don't like this interface change.
>> It introduces churn for no good reason.
>> At least I don't see why you cannot live with the existing api.
>
> Hi Alexei,
>
> This patch was part of TCP Prague preparation series: https://lore.kernel=
.org/all/20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com/
> Our original patch is to add an extra tso_segs, and after discussion it's=
 recommended to replace exisiting min_tso_segs.
>
> This is needed because TCP Prague would set the exact TSO size rather tha=
n using autosizing from TCP.
> The TCP Prague itself is planned to be submitted after all preparation co=
mmits are accepted.
> You can find its current stauts: https://github.com/L4STeam/linux-net-nex=
t/blob/upstream_l4steam/net/ipv4/tcp_prague.c

You have to explain why Prague CC cannot rely on autosizing.
To me it sounds like a red flag. autosizing logic was there for a decade, i=
f not more.
And now you're arguing that your CC logic is special and it deserves new AP=
I
and breakage of existing convention.
Maybe you should step back and reconsider.


