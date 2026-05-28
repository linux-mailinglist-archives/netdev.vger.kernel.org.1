Return-Path: <netdev+bounces-292668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAzCDVooGGrneggAu9opvQ
	(envelope-from <netdev+bounces-292668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:34:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F10E5F156C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4387030048DD
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F53E314C;
	Thu, 28 May 2026 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElLT4BR3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A233B7B80
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967908; cv=none; b=SOlBVnFzay4/NkdDQ/qTkU2xH1EWjVd2PIOlMoMfFS/rpSzIGzO6iVFjzIKwm+u57UwOr03wvZWcng9fX1GfsNYOAfZRtULjPXcBjn4BEOpVh88bviQ1Wt0FxalW0Ky6kyjXdNvGMHVsqpWTxqn/zfiivuwiQ1pH4CIFDa56cF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967908; c=relaxed/simple;
	bh=W4VjU27CwaUerJOwwghTsdzRPYwXssfZqA8ifH57FCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrT7Af14EA0+O7DudDgG1VSh2Bru70JSVcLtVyVoYcA0qTnTMPfiIDQzKwnX+hFrFJI+vd3l/S5X8ChOBCujpdaS5Yq2S895f2DiSc9tHupgYlacBBdBjvas3QVVZD0ruMQUFdLo1oSxCSeoyn/jnClZCSQoj41S8gEudUn+7Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElLT4BR3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49039a8851fso71384235e9.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779967905; x=1780572705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3EpHtLh1zQvpWDlk41yMlCrZRHl2BvqLYi4FCIgtG4=;
        b=ElLT4BR3iDlEX6zil8x5zNm6Mlw8Gcfy9RsSdm14zkmdOl1MzkScqFlhInT2YvOCWn
         dRj53hQ8kbYa1DDvDv89OLncPURD3UVkGqV/7t5WLLvacMZLOEltNv0jg1aWwYS2E0MV
         gfsHcEZWl4MqlfAtTATvkX1NlYZQU1Be1gOku0xUr5j3xYdamvnUQuKDhiLHgYGaaAaI
         B+qWuCVzC5E97DaoslkcDtFmZGf+yetUrWiR6nlJW8LlTy8U+S8SU4F0F0wZn3B59EWM
         YkOd3ea2nSYOLnBTObxkyuHlObW730S4oamKvENq1MR4LSmcWYc2KfTnDGGuk9Av9TEo
         1kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779967905; x=1780572705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/3EpHtLh1zQvpWDlk41yMlCrZRHl2BvqLYi4FCIgtG4=;
        b=lGq9668QS6KMCOXJwmnhU2ZN035QAk5+xFb2aER+KbD2OeSX3uUPOp8Bu02R7PWElT
         tlAF8furOfMbyJ9X9W8rjqvlkfbLwofefMRfpEOITLERCI2Ee+3UAgScw2cSHTf00rJc
         84M6eFU2wbVOPb71rC+G26w3tbUveB7lS5gAcNDJgmhQx63VA6TxupYK149nYg4plify
         txxxR49moPsBU27xpOspuHb87nNmQOWgKWw/LSeIWdTH2Gi70tz7EuhQZi6wj0veeou0
         H3dPr3mW0qdTAAGfU/y/my04CHDO8bXnDuuyKPVwPegLH4boCXmDZSoEOi/cFuJXhY25
         M8iQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rp4T65KzxNe2L4uuSUricu78ZKR1FNm36v+8Mdd3IiJ0JSm79YUTq2+M6zx5lAphsjS4b5AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMfPmrpyh0aJa54HH+nI+K6q3KwxTD8lNH+LYkU8rCCJpLQSXi
	TRcWFx1SJ3RFaJp9pk3Q8BI06VZDnIy1RYyNecm9Qcm08tYGDytaAR2V
X-Gm-Gg: Acq92OHCo8+2zXORZtAJD5GrEMI2sJaMEPUKAGU+QdIMkoBCfebYzPgSfddeIHOdLD8
	MFYsdtwQKyNixN58VtYHGeCMVD+wbTiQzgj3mgY/i9uMoI3H3mevd/UPzohx1KkKNN9b2ABjjgx
	xXpWoPXS4nbgqikxydlWJ0FQe023gZemhv8JrFU3ToP8euSxx04WB/u+LpCdO3W2wbrdkLE7Xmv
	ZugTJ0hW0DC+EJiuR4j9xJsMduMnf22pF6MBgTJZYUREfW+KgGxHLvSZHi/sFIV0qtTyNCaI5I6
	X4kFsNla50rmt7FU272Ik2y+W9pv3pmLbEJafOAoVhp9ZqXAB5Can4TwXA1LZSrTC2XxRsmkqm7
	HqMi7jron4RqXbid/xVs/I/aojNHidjAqfu6C9MXSyKrLtTtKd7NAcpKV8JYhkZxP7H3g9V3EMW
	pV91bAoxLXjeRtZjDvgNzTZ9GuKS4yjN+1yCEuqPumx5V/Abjok4+MKWW2cCIMMigVQJE/+RM=
X-Received: by 2002:a05:600c:1c21:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-49044ebc29emr447205765e9.21.1779967905331;
        Thu, 28 May 2026 04:31:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee91c34bfsm4243998f8f.2.2026.05.28.04.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:31:45 -0700 (PDT)
Date: Thu, 28 May 2026 12:31:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, victor@mojatatu.com,
 yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com,
 rollkingzzc@gmail.com, dcaratti@redhat.com, security@kernel.org,
 linux-kernel@vger.kernel.org, Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net v3 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
Message-ID: <20260528123143.1a696fee@pumpkin>
In-Reply-To: <87ldd33l7r.fsf@toke.dk>
References: <20260527181731.1166373-1-jhs@mojatatu.com>
	<87ldd33l7r.fsf@toke.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292668-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mojatatu.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com,oss.qualcomm.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8F10E5F156C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 12:03:04 +0200
Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:

...
> > 2) Add more optimal boundary checks (Toke & David L.) =20
>=20
> [..]
>=20
> > -	if  (offset < 0 && -offset > skb_headroom(skb))
> > +	if (offset < 0 && offset < -(int)skb_headroom(skb)) =20
>=20
...
>=20
> However, I don't think this matters, this version is not actually buggy;
> so let's just get this merged, and we can code-golf the offset check on
> top :)

I prefer it in pink :-)

