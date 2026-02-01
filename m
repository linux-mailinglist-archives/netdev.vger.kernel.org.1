Return-Path: <netdev+bounces-255593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v5IhGgAqf2l+lAIAu9opvQ
	(envelope-from <netdev+bounces-255593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 11:25:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEDCC56E7
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 11:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AB3B300DF49
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A582EBDD9;
	Sun,  1 Feb 2026 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIjfYEv3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424EC2E8B8B
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769941500; cv=pass; b=LXZwLNLiiJXOiR6pOIkH9awcCtz1EeStg5m4PWeZU2X1MMcvLFdxhz6sYmg/+v3ORkVqdabFn1VCYChvFjaGMk3QRiAbyRwxz2pk9BhQjvhWOcSt3CeKQLUEM0Hw75BJ4PRSQl7bAWYthrzLDbN6pDot34a5T3+B9ObHm3sYo7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769941500; c=relaxed/simple;
	bh=c13X9iCoqEMpER2AIG5Pt/jrhfKFm2Mm4FnRZDWIDoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCCCu3HkSjVEpVKFXdhYTLMy0jRtI1XQPdvbZf6w5KD43rKpKnQGElX4lziHqR3s+xr76cf4+QFQf8MvQ+S/D7DDyBms/tIeVq5NiEC+pxCDvfy/ZrPJkx8MIIdbgtfs18xl5MuLCh/c4v8l4o2rN0uExy5qA274P1kkTpcQTPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MIjfYEv3; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5014f383df6so26562851cf.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 02:24:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769941498; cv=none;
        d=google.com; s=arc-20240605;
        b=PtAHYxhNQZqFccCPmReu4ye/VJNoDeKqpQ9FGQIryHWuVgbPkPSn8XbZ4/ZcKcUuey
         Stuc0VhRIRcb1XjGMeOX1I8109T7yS6z5rOOHOmkBJsXMxQyPh/1SYBrr5lQqjYuwm3C
         L8PiXRDVUaqZfk0NhkUA3lVbAr7MeeJK4xPNMzELxLR/bSIwtifRfotGCifslvBPCHk6
         QkZ/epRLXNwNQvwotNBgy0w3EQFFK6nrfL0D5ryop6UxAFYq/nxBM/5fxozL6fSEo/nX
         6QVnM9xrotGQJNNXagTQXUxwXDprvQxyCrQ7qziBx9VALABoJvSY5rvZgH9Cbqg6cUY/
         4HXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c13X9iCoqEMpER2AIG5Pt/jrhfKFm2Mm4FnRZDWIDoY=;
        fh=oKSsOuptcpg1kgZ6JQTGQBjGiw1IGe4K5E43GKh5vf4=;
        b=KtcJN6hRie/FnN2RLw2PyH2ZCst/Us8ac674icrvmiU+VX+WceRqNJe5MgNML+UbYD
         V2voj765JhttcczR39MTHKtgqrb1XHVcvp4LbTJWM3s+SUmXGUetOoADxXYlS8qYW5LR
         G3b8GTBn1S3gKq9WDS/WosNkQID/35yTbVEnwh147BPFp99qjF1NMlEQqEvR4pnDn0pW
         YnSzff9uqbgRBV1xbx5YHp7xVO2KpZEyXwWQt4jzvHU3Dev3LXmWJoroJZUvuF+pck5o
         lRbn5kwR1vG/50Eaxn75K2MSofgEJBjXrta19TXXpAFwRPWfZ8Mpydh3I41RrMOP8pLx
         LUUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769941498; x=1770546298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c13X9iCoqEMpER2AIG5Pt/jrhfKFm2Mm4FnRZDWIDoY=;
        b=MIjfYEv3Li6hV8HO6FS2uLcjF2ZAWGHiV2K89t/jxIh7U/LFzvM7tuO2Vr0/5fAJn7
         W1lfRwlTpWXhXqgkDo9uwtizhOwQRPz4HZdv+l/cD4zGjTfanmdcnduR+P22Hu5jZ7RI
         R/U9Zjx5A/YmVYq23CZNHb+ZCaXbCBvoHivYaqTxjcCCrz8ZCx6XpzR+TveF3oVJgxAP
         KSlevuxG50TfBx/Sb1MP1A9Cnj7QJCoMtBAKEl/rhCE8hMbQTz5NuwYkuJqx5vHQQ0hU
         RacLMLDg/KbdMT2Dz5cCfjeZF3CWGCPZVJVJJnnPi52nFe5T+rxN62m4NjSRllgAiQ+e
         rXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769941498; x=1770546298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c13X9iCoqEMpER2AIG5Pt/jrhfKFm2Mm4FnRZDWIDoY=;
        b=s+9vyvKihIf5SLp5yw2adfeE7G5JvYr8H6TWvtJw9YylYU9OIjkBebbjeyvD/1Aj0i
         sBEeqRP/23MioNGJbe8VN+dDZcXcIydd3GvQzohDcZO7+yTtprf3vyjk8V3wdO0FBAA9
         ogSDWqonDEWR0eDgr1RJTnz3UiFXhN7imOQsFwo4eQ5I460cX0VkZDGpliNYWVTNe618
         KzXxRt3bs1v17HmHLfWk8ssJPHZzKSZu/w6iTGdHTAK9zvi4MmRTBwudw93FdsEDN8vd
         znQkLCIOgPU0vOXgJtQGbgqzxxa7k1Jd6n+jH6pzGHSHEn5CRwn5Xcl9PfFUlctoUDEi
         64/A==
X-Forwarded-Encrypted: i=1; AJvYcCWWCY4bBJXELMKZ8bd6aRYeXfR6z4/PpqweuvriiYZ0MxVNyK68NttM3bM7JG3+Ymq3s2rPsAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IUMckh/u4keleTYn8NS4laJWDbK17Y9w2uH6MsJwGD/tNNsS
	0uwW3ZCr+0hc3SixlqRmCz7+zfSBQsSO7W+CYCdfa7/QlXIY1MtiAr4KEIKMefuf/w487c+147+
	ar0U/XIrugELaltppOwtxSp3Tw81jA97Crdd6RN6D
X-Gm-Gg: AZuq6aKa8+L1FyoLEFfK0vo9EAhQPNn2rT4IpGN7Ic5R9FWfzKQ9mwi0nnn4UB2tS24
	nHiWBejPigs8hD7NWbw/PAsmZE3iprN+DsxhGIFTj7XP/DG2CYoP+FTFRjZUCg67JzwUkoxFc8i
	WdN5MROZfz4owv0A4PZTmMhUZ35mKdKwBWXefdQlOQ82N2EXQllXVaFgGxB7+SblSenkhEEX/X+
	cZlbC/HLu+q8dJ5yCOc7SmyaSqZtj65Nr4aC3umUD71tjMXjI8ZdP67PzrmJ/UAVdH5Pd8=
X-Received: by 2002:a05:622a:510:b0:503:36ba:1315 with SMTP id
 d75a77b69052e-505d212dc92mr105121131cf.17.1769941497854; Sun, 01 Feb 2026
 02:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com> <20260131222515.8485-13-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260131222515.8485-13-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 1 Feb 2026 11:24:46 +0100
X-Gm-Features: AZwV_Qje-4lGonBagy2Li1XCvjDteYMc2SXNllbyqn7JUJVP33Ro8aW2ZhSaRR4
Message-ID: <CANn89i+8vG=DiXrd9tbv2PCH_ALpDYUKsj5jm4Jk+G7Qp+2EPQ@mail.gmail.com>
Subject: Re: [PATCH v13 net-next 12/15] tcp: accecn: detect loss ACK w/ AccECN
 option and add TCP_ACCECN_OPTION_PERSIST
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255593-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[33];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9CEDCC56E7
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 11:26=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Detect spurious retransmission of a previously sent ACK carrying the
> AccECN option after the second retransmission. Since this might be caused
> by the middlebox dropping ACK with options it does not recognize, disable
> the sending of the AccECN option in all subsequent ACKs. This patch
> follows Section 3.2.3.2.2 of AccECN spec (RFC9768), and a new field
> (accecn_opt_sent_w_dsack) is added to indicate that an AccECN option was
> sent with duplicate SACK info.
>
> Also, a new AccECN option sending mode is added to tcp_ecn_option sysctl:
> (TCP_ECN_OPTION_PERSIST), which ignores the AccECN fallback policy and
> persistently sends AccECN option once it fits into TCP option space.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

