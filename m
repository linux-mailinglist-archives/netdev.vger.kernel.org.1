Return-Path: <netdev+bounces-285539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJUWLrUY/WlLXgAAu9opvQ
	(envelope-from <netdev+bounces-285539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:56:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 193854F0049
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C485C3020A81
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F634392C4C;
	Thu,  7 May 2026 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ar0i2lFE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B932D7DC6
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194611; cv=pass; b=nH5U/0rhmUiYLri+nC6WZYX3GsPr5VkTtDlSjiqweXbvw7lkFiTMd62a4tTCX8ILgWk3WM58ZSSvXkRC5PHIlvHGhhPDMojri4PuZZC/0nRMjJIX4w6Kunmfvx24VbIZuq0JbBpsgCLDi3AAKSRXYtDgGrNpd2kcbT32ZnzVSHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194611; c=relaxed/simple;
	bh=GgIxkriM8U1gxLSNkIPnw/ikY3kzH6BWxnfvfx7jGXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inQqW3h95A+OKBmpCYUjkQXRBgY/xNbwDqzg5LE6q2FCvK2arZ2+BPbJm1BAogHH8wQndilz9BtxCCPgEjSefrbxmCt+VVHJGG9gJp1K9IrCxCSXs6zc1PDrOzrEnImzBrggzrF9yt0EEiaDf4HFm7aBLxAPqTHlaghk/Q/iyfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ar0i2lFE; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12dca45ca21so2226827c88.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778194609; cv=none;
        d=google.com; s=arc-20240605;
        b=Fo7DWsjXPwO3DZTY63hbddJowYqNxevPPDDt+2w2dHX36RQPByrJMRrYS9CttqWts6
         1VO/0G7diWm8c2n0qmlVU3RkJIJnS0WtdT/UUZV/MiXczN8AG3q1/HqWLjvXPRL8cCwf
         YV+Ms+uDdz6FwNr+2We71IMOhY2CIZu4Gi6GTz1NvD4mYWPcK1UHt+/gS6PM/bDq18vf
         8uJegqOnK1UMsliZwSMx04zmnEYTvwNVRd8LGMy2qPupxnOH8DJngOmEtwnKVb7V9iQp
         PVWTYCgX82XaMewTSIflKHPopZxWplOtWBLp6meHeLCp6crqTORBt9tW1UBTSKjr8ES5
         0e5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GgIxkriM8U1gxLSNkIPnw/ikY3kzH6BWxnfvfx7jGXc=;
        fh=EWpQ5S9ylg0JkatOrrZwEwas+/Fo6KnT0ho1TNe6Gd8=;
        b=C1tMFyJPRDh79fy3GRuso9TJR8Hdmj+egp6FP0paSuO4ZrxjeAKUl9bilm61Ez4Vas
         aQ/jN/R4GWPWCoquqgGuw+Tp4y8jEmsVUC+SWRu/41PxJdkJauKyal3qUWWXMIJDcIHh
         +I70HZdUuidfy8FJ8fpH08VmMICPTEPIJn7Rx144sEtm43Yxf7c6YNHlf51812mhCEG4
         6yH2s1RP1gMmhYACmYd8WvrCpkEtLif/4DCPEsOGaiJ9w8xtkLA4UfsDhLKBMTEmEsy9
         0l3jTC3VB14gxCVwSf9ibrRW549WBPQllyw86NgxtwcwvrfPhDlpXG1fHvmcckBTxzqY
         j5LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778194609; x=1778799409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgIxkriM8U1gxLSNkIPnw/ikY3kzH6BWxnfvfx7jGXc=;
        b=Ar0i2lFE2elZX+ZmFg6FeOqJJ7acPPvc7+7C5W82g2VWom13uw6MXaYBqylxsFd0X/
         qraw69E4GKG0zIKJ4yiza1b2rTOAS41814llQXpASzHGZvhmBHCu3qMXP5ngruIgz7Kq
         UUWEQbHzCZrZ48910nLFJupwQ1Jl/OGAKEhuA16ZekqfRXHkkd5HYGzXrgsCvXyHIaFi
         Y42fuaK3DnWvnylBuxhssbARcUW+9keN3G+nKtanwZSj3LYe1I7EpLpoFCLoSence7Y3
         /qyWdmyiUlKyxerAKjD9fEG+/N7hrcf/FRNVd7bkDgH8Qb+CuxxIE3nDaEMbP0DuPHcB
         ZwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194609; x=1778799409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgIxkriM8U1gxLSNkIPnw/ikY3kzH6BWxnfvfx7jGXc=;
        b=Oho68ZxovK5G3UehMB4I9OcvQRRRAN8cK2ysuNNP3RRJDZwaNibdUXAPTLOXKucjBT
         M3OTimI26kW94KZ0mvG6n1p1DxJNs2WijjP/foW2oU/YqgKya93kBSnDrVfgU9YZNF/r
         UT/P5spt0BcVkuEXuKZq9EIDLQB3+sDV9nRvl/ReiQT5C3rQw0kKOy44xf7FUA/ZE1KR
         t57RFaHwArBMUg/yNwG4XVvNuRYa8Z3wn3EV4XLncnSUo1gs4KzdFtPp1SvrMwZiq81a
         SpcLOzhKEB2RfkIMtn54OpKQ6zPbGvUbaNWadHZIFpoBsQFR4xDUiJIzVG7ZvG30VECP
         rURg==
X-Forwarded-Encrypted: i=1; AFNElJ/x8eSmGXlr1VZbAcxBILaJfq3l2czypII+9pxqp6uAfNJZ5xSA+8gvEFEMpIW6I3zF60eOPOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIckADwe27r+pwn/9UKZS9k89uaTr50qigXc2eKiVKU03FHiTW
	BTcR00Nvz/KM+rDKvHazcwuf7k729WC8wwCsIXmqHqYv8WdpjOVfhJy2VYHfvfBqg92D+MV46m/
	yDdiyLBvUoJzcvKA6EkJcl5/VnkimQnjQohX4ewEc
X-Gm-Gg: AeBDiesUPjqXVRJBxVoKOhaGypFtqInkyEdf5LyfLE9M2KdnmPO2yn8fUOH6VsrezAa
	sR4z5WqFUWawH/v9JgTdxKRb4mIcPdLJXv95cKTGLRNqOKPbo1fZVAOCGZ6aMFjhfaqz3caOG76
	nYDG6zRmG4lpJfuzrWJaB89erXDB2eM69A6pz8T80qxjiPkj5dmiuAj+n8hKtTWeDoM0J7yoFul
	9d/HkuFpxZleIkJB/3ftIurtapsVzdKrQZ9W8dLbeU+sZwOS0yTaThRb2ouwD6KJc0t9c7gSX1S
	3n1ml8pK4Bc8RanhLy1CnOEhjFq+JpjNy6tl+WVICNabXhuznUO4sUabAzJBhSh+UnBf+/ZdhTk
	5ap+9AnKJCCFoa8J+Pa3SVMUI0FUvxxk=
X-Received: by 2002:a05:7022:fa07:b0:12d:f0af:110d with SMTP id
 a92af1059eb24-1318ea2dc7bmr4811166c88.28.1778194608607; Thu, 07 May 2026
 15:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507084305.2506115-1-edumazet@google.com> <20260507084305.2506115-4-edumazet@google.com>
In-Reply-To: <20260507084305.2506115-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 7 May 2026 15:56:36 -0700
X-Gm-Features: AVHnY4JLfqY_0EDZ2b-WtV1hfaS1a4vFQwnt1F21Hsc_rZHJ8jxHNbMTo_sA8aM
Message-ID: <CAAVpQUC7E+HfoHBsTDcLBJmYgyBwdPWCexb-9ZYFPOokicT-Cg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in inet6_csk_xmit()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 193854F0049
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285539-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 1:43=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Replace a bare kfree_skb() with a modern sk_skb_reason_drop() call,
> and provide IP_OUTNOROUTES drop reason.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

