Return-Path: <netdev+bounces-273804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEWNMXhvzGnJSwYAu9opvQ
	(envelope-from <netdev+bounces-273804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:06:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9CE3735AE
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99052300D749
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC80257855;
	Wed,  1 Apr 2026 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7T9W+9b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690F1D0DEE
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775005554; cv=pass; b=SNmJRPTHDd0xpwA0DM5W+Rc6UUksoFvDx1gCFOxB501UZoF2DDOGnx+GsaZzMf7yNva5vOKc00NnwObEZT2H8M+JWnaP7UaTFtVAxR/s3nEsDtVgRwmJGbgS1E5/eS27Ymy4ILEwX+8W/QOuuz/KX+sUApiGurx4wzAqkrvfQMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775005554; c=relaxed/simple;
	bh=kZNnld6Viubni3IF7L60kFlduRlVjfz7xWymduF/vAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FV9GLFSXewxaCg8HTEqw0x3/6bQcE8X5kdxQ9omMmxqihjKDPb6vlv/JXjnTmq69FJzzqKi5EWTUJEVrKYwdnvyjhV2v16wpnU0T+fhcybSvlrRgilwloDDaGH775gVJ94Vpo/MhDP6MwC/Z2EYhmPVue3ujWt9zcgRQUf5ZsHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7T9W+9b; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506251815a3so53486641cf.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775005552; cv=none;
        d=google.com; s=arc-20240605;
        b=e6hBAMtFixuq/+2nQk3CfMBa7MmYtFyYrQvuLexMpDTMc3Mpjj8in4Bs7e0Hm320Df
         77L2H33J+rutyqvmKxs7eB8JYpNOhQnuzJ33lPns2HrbfVF6pl8vpH9HIYa0eD53fhBT
         Zc3mMgzPAXaO6IT4BIB/6GASZxEb8JEzMJm6A9kls5K+4zetd2gDlbrh3kS+c9Wfl7WR
         uZLPfPDJZ1rOMADASLe80ekdM4DQSJIIMZMbsZag8mwJFBb0qQsmnxSHD47YQk0IX6b5
         4gZVpu+QW6b9YV3NIN5Ll3ux7BuoycXs32sv8HPuKD8aM5GfV9ANApgFqJIru3ns9a1m
         LSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kZNnld6Viubni3IF7L60kFlduRlVjfz7xWymduF/vAY=;
        fh=irM2AnLFhzikdFUrnuwJUiF7Dbxra1FC9tK6LpbWIns=;
        b=PUHBQqC3BPFqbjx/Cx0e0FLCLvPB/P5n5xDkEYZBFg3WsQu69mtwbdszixOKbdC5zc
         iyOIq+LyhAjg+Wio/o7JX0XnbWZ8JzbwnwHAXK6rRcAPfTfqUVao7IDWyKvBey/ajHCb
         PGSqkfcwH2Ij8hA9YCQxByeREB1egCSmDyqDOctIv4dszdbd50EdWQXfJnigGPg0Vye3
         aG35E3qNkjs7PR3qvsGwsQwFLZWp1cnepNLRapbvMo9ll7QuwwEZQ4KRumQ8qFVl4Egu
         8PR52ctxkKjQDGGxhJQN6lRtLx3EcMJ4OMxQO78eHJZKM/09gKUwOb7g15FtSPuw3/bg
         agoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775005552; x=1775610352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZNnld6Viubni3IF7L60kFlduRlVjfz7xWymduF/vAY=;
        b=i7T9W+9bmwqZeC8e5UEof6BusxubJnxFpA+Cdeb8eLBhKBeDgvjdgfAch2djhfJ/jB
         M7ZsqYTl3E/BTwewcKQjgLkSOJBtNa0T1R+spBuVDmCn6udnHvq84bC2XhETkX1GOk7f
         XwXuzc/eKqVR81EhhEJFNOBtgZApyfwvgUNzHFpo+Z03JtEaCy2bl94epUF5om1mle+e
         PzwzkBX3/v7vRaX7Q+4HX2kny81jPA+ao8zsqBQRdGG7u9cPSfyNrS2BwmE0Y7uxlv43
         9Es5oNOrLqqTnDj4x15D2LaTaihOmH25e/dTTpEJl2CsjHxwKRScvDaoqVULnWd82a5i
         3YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775005552; x=1775610352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kZNnld6Viubni3IF7L60kFlduRlVjfz7xWymduF/vAY=;
        b=H0pYi0ecknGMCi//EggfDR3SUzqd9YjeaR4f7Vq7UlHBIg8bR1AcoL/5+JUokR6hN2
         1249QYLLKme6Q4CPdTkxFYhIEVnIMojM8Faid/oGeH3SDoYtxar9IG4AD5PHMLSssQK+
         /LnkxXFJ+GlN5EaXzXUlMc4cbpCAVXiP998BxGAUVeMUwQkvwIIQEcr8n49+1DCqkajp
         BA9+AGlO8VAsOgZ5e3t6e2nweyyL38gDnWQR0TBduXRHXS9m1nA3eox+EFNj/S8JCunf
         HC+tvn9GU2Scw0kzvIJOi3FVWaWq+iydWSrleGecsmxmqXotNWl5uLV+NuzM2S5xljjk
         ay0A==
X-Forwarded-Encrypted: i=1; AJvYcCUuObH/QKcLdmFTIOkqmSDZRusjSEF+l/ScAUvC7OzseyyD0jUlHuX3/fon3XpUREcCd1I9RX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKmtC+DIkRQCrvgDQXyF0p3zwWeQjwGB7c5jNkf4iO3D6XuAMk
	Kh7QFxBiIXdkUdnzMWxS0NsCCkA18XgNT6Nh4LBnpuYK+7sKC7bhT4S4j8XJk807mYTRQ8XDZ5V
	kBFLfII2xzBiKajUDLvDW6H/Qe9KT2iYZb7blGItz
X-Gm-Gg: ATEYQzwHConyt+Fq578xbmPPwNm5C8ic889iL8xuhGtJG5DrL2sfWqOTAmZR/m9reyx
	XHQKq3QEkciLWVjLJXWpMNnCVLkUEhGMXEorPlJsn0lnkA/jXTMX4jdbnZMGaBPWZTxg4cGD2PC
	Y7YvMB3YpjoXYgn+NnZCse1eaDhagJrJ996BrsTDy4n/yq+nCZMWS69YLdeTdXy8ziQm6QyTV7b
	/bLJiQpwxXWICelrUh2ANoSQ5Ru4uijMczyDlzsf08RVPfETloQFt6tOBJXlWtfb0It1GaOcVg/
	wCVjXS+EhfGtMx/z
X-Received: by 2002:a05:622a:1244:b0:50b:5089:98c7 with SMTP id
 d75a77b69052e-50d3bcd6c96mr22896351cf.37.1775005551253; Tue, 31 Mar 2026
 18:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774855883.git.zcliangcn@gmail.com> <07351f0ec47bcee289576f39f9354f4a64add6e4.1774855883.git.zcliangcn@gmail.com>
 <CANn89iJ+pDwKy0kKKG8PrSWMXEStgsMP9YGLxwvjcmMJP1PwrA@mail.gmail.com> <4631f54a-bcc8-454b-9355-15a21f9e1e21@gmail.com>
In-Reply-To: <4631f54a-bcc8-454b-9355-15a21f9e1e21@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Mar 2026 18:05:40 -0700
X-Gm-Features: AQROBzDpkmJNzPVNUD_VvKhj0VCWPE6--KGO9odY8NtuUoR-pqok8_5bDTtuGJ8
Message-ID: <CANn89i+XGF+GheZDO+aWaw5V18mGu2H4OWsCpfs7HriGvCsCRA@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: ipv6: flowlabel: defer exclusive option free
 until RCU teardown
To: Yuan Tan <yuantan098@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, security@kernel.org, netdev@vger.kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, afaerber@suse.de, mani@kernel.org, yoshfuji@linux-ipv6.org, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
	enjou1224z@gmail.com, zcliangcn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273804-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[lzu.edu.cn,kernel.org,vger.kernel.org,davemloft.net,redhat.com,suse.de,linux-ipv6.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,lzu.edu.cn:email,get_maintainer.pl:url]
X-Rspamd-Queue-Id: BD9CE3735AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 5:41=E2=80=AFPM Yuan Tan <yuantan098@gmail.com> wro=
te:
>
>
> On 3/31/2026 1:52 AM, Eric Dumazet wrote:
> > On Tue, Mar 31, 2026 at 1:34=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrot=
e:
> >> From: Zhengchuan Liang <zcliangcn@gmail.com>
> >>
> >> `ip6fl_seq_show()` walks the global flowlabel hash under the seq-file
> >> RCU read-side lock and prints `fl->opt->opt_nflen` when an option bloc=
k
> >> is present.
> > Some points :
> >
> > Please do not CC security@ if you submit a public patch, there is
> > absolutely no reason for it.
> >
> > Please do not resend the same version within 24 hours; this creates noi=
se.
> > Your patch wasn't lost; we have many patch reviews and similar bugs to =
address.
> >
> > Thank you.
>
> We sincerely apologize for the confusion caused by our previous email. Pr=
eviously, when we sent reports and patches to the security list, we were ad=
vised that patches should be submitted to netdev@ for public review. To fol=
low this, we are now sending the full vulnerability details to security@ wh=
ile additionally submitting the patches to netdev@. Please let us know if t=
his is the correct way to handle such cases.

When/If an issue and a patch is sent publicly, security@ involvement
ends. netdev maintainers take over.

Thus there is no point CCing this list of security officers, which is
currently flooded by many LLM-based findings.
Please help them by keeping their inbox a bit saner.

>
> Regarding the CC list, could you provide further guidance on who we shoul=
d include? Currently, we are CCing everyone suggested by get_maintainer.pl =
because we previously received feedback about missing relevant maintainers.=
 For public mailing lists, we should only including netdev@. Should we be m=
ore selective?

Yes, folks that are interesting into following netdev changes are
subscribed to netdev@ mailing list.

Unless a patch touches non-networking parts and requires approval from
other branch maintainers, there is no
point CCing other lists.

>
> Finally, regarding our tags, our team has a clear division of labor=E2=80=
=94some focus on finding vulnerabilities, others on fixing them, followed b=
y an internal review and testing before a dedicated member handles communit=
y outreach.
>

You included 8 tags, this seems a bit too much for such a small patch.

> We welcome any guidance and will improve our upcoming patches accordingly=
. To be honest, we are currently a bit uncertain about the exact workflow t=
he community prefers, and we are eager to align our process with your expec=
tations.
>

