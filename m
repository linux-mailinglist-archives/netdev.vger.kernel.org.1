Return-Path: <netdev+bounces-260775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIUJBSOXnmnXWQQAu9opvQ
	(envelope-from <netdev+bounces-260775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:30:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37522192612
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9B8A301BD5B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 06:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835E283FC9;
	Wed, 25 Feb 2026 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBROCg6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572BBB67A
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772001053; cv=pass; b=OHCQisXU4R9ydK1R4TyEMHfuKp5dS0FstKG5kf+X6LmkdxugBpfl+kZT9/lrWvZ9jXF1aci80x9j9cU0G+XX0mn0LSmKcfhOXF4NMLiaV6uDnylOd5t62XakjqsoHw4G2Se0sDIowX6pr/ZMdUPmNnBomtmnkFP56PBcF4KxCvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772001053; c=relaxed/simple;
	bh=at6/P3ttNsCUbOJppHqZ2pegCdYl3F2OUPNtjyPlap0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQgq1dy+T8JS7rkJTZttgDVV3RerkyLbyNLRY8f9c/I76y82WO3sOX1B0X/MBmxPtjpYSxOT/8XkElA+myAxuDlTWo9pxY98IvQ47nfNjIcNUsF3TzfaFq0AlmfeCI0weuskiMvj++YOJ1JUPCvWI4WFacSDbEiL3HUn7Cg9BOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PBROCg6T; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1271257ae53so6191574c88.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 22:30:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772001051; cv=none;
        d=google.com; s=arc-20240605;
        b=J84odxyHceAhZR5TjCEw0eR3irQLfpT7z83m30DpJBQm2w7SxUBm9qlAuCenXeVZL/
         oUb5o1blv1ZXWVRKfUlvI4AH54DnarrIJJ8Tk4rbIt5cna1/Ho+b8IdVr8y69ddWWJtU
         DJM32VI1ikSsJIybYWeHqEkOKHK3MKNIo81EClPMj9ttw4eAJdGWsGhEN/dhF3YkFrU5
         DlY7dcre5irhFx4dMNrZC5fDSZJArZFCjaAa6oI5CnHmATD+06wcQvg6H5eGyb0nllcB
         Xmg5ucKnOL7SRAAkLBfDHX0h9suPIkSKJ660wgWxhCy35NN9smNLpXNzOqf9WdNqZolF
         ZN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=at6/P3ttNsCUbOJppHqZ2pegCdYl3F2OUPNtjyPlap0=;
        fh=y37KsganT5WX4wjD1Rt2Es/oaYhdjr6sS4iiolLGoEY=;
        b=Rm8iHUqNMnwsFpYm7m87tShxv7Sr+cOtQLnFHBdCw+Y90vAqdgXmLYnSn49SCU6q7+
         qQ4MSyBFE4LWhMv+lhxc7ITclPKX2RxafAhb2ZH0FFbdaN3TWhjwm27TvupPbwRRCqTX
         jwsI0e3dljU9vYGwVs6rRFx9urYlJCNaDzAh0EcijbmHuGqhPkFH17mX0UURn3aRrQWI
         HVTzyDqmLIP+N4ud5bGViqyEaKKA6+dhaNKs8tmm7hD7gPyXB8a4iAxt8AfAT//Rjzv5
         AsnQzi6JURzY+AEfN9hiluUzKQvSJpcy1fRRsTL0mpE4kFRPn3DoLVYgz3BVJ5xDi8sT
         vaSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772001051; x=1772605851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=at6/P3ttNsCUbOJppHqZ2pegCdYl3F2OUPNtjyPlap0=;
        b=PBROCg6T5ayen820I9CSeDhy7v4wQCqtqcFPeN1Gi91L5mUeVmHp0Drmj5Iar2DUO0
         yo2s1h/p+2iQ51If/GTfHV7ciQ85kJDCmfOXuboi4HDTbIIJJRaVZvXyfFtpRjuxaU3k
         0IEWKgObmWtx/vI3MXdiSqNRu8GzrTOfq81zWF7BFula+tUZ6RcH/sLk98yjKbnWFZl9
         kSybsYpP+tV86bDG0nIwj2JH0MaofSLA/0rt7QSklKImazMBC0bXWVo9NJj3LT8wS2Ss
         t9jIoVLi+9xE7GX2jKmmCI4c62VgCh6VxIDndCaO6xO7FOjZynzi6vh5j+gwpqymOu6v
         g7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772001051; x=1772605851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=at6/P3ttNsCUbOJppHqZ2pegCdYl3F2OUPNtjyPlap0=;
        b=CzxQd82cpe5ZEKNL1h7etME/G+SNfiJFM4PW0B9b0mKeSuRfBftQJSKmPzsbbkDp6T
         lNVLLMJVxpcAzk/azNNFE/EL5Ho731WuxRrY276HIhCaYfmZY6p2QbmdJ4AZodvzjx2Z
         UyRTAxckPKkO0+LC9VcYX+GeNqrzFkspKuGvJYnrVOA6So/157TNCQMnq7FQTtxXr2Sq
         lnfvVUL3d/nbq/jZaB2nt8QLd3ZkRBr92B3RP8kNHd84LmH0P9NWY8iFzYmqoT2/2UUp
         HmdGFj0Xpu4jsdIuIevmTM9p7cYs9ER4J03dVcbDAq+thG3o/OnIyHRRUZHXNwj0SdUC
         /RLg==
X-Forwarded-Encrypted: i=1; AJvYcCUaqMGBY+CiXqvdS/3IDQNSmu8qUnp86ZwW0lwZGrYTi/Mjr2ZLshizvi12Udl+eScueWCE+XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXD4SSkqdZkHOtIRoL86WMBwBrgWqGwBaoW6U2V+VIn8+6uji
	BqfkXKtKodHWLe4Pg4RSMz2BVv6J7PE2N9iHzUSpmJlY5mvPdN2hI3y/vYPbX7GzHvXRwZCtSwv
	/UP8zoBnUJkr+kFZFnlZHHE9ZfsP6qCQwayiN3QwA
X-Gm-Gg: ATEYQzz9sqtUFynDu0InZyWQICjv1Fmvdpy+nDHdlM5aDNDvlUd8LzbQDfakoUqrlG4
	L0c5KYEBhmm9sGhV84YLmxoAGMCW1vIJDoL71e3z1CDhKRfzUp/uCRbPAlRi8cTURObbS5ngsOo
	93PRvu23XCqvlZhWNAl1aPB3chaFosFgAtBOkZvqDK1E00Xif5JhedETMOhk/1duS28FOXragnX
	Q8EcC0pRidaH59FvNVOjZ2HJyVLmwcVxMV1rOzSynDJK8+BakDBdsllCFQuRpFU62Md0H5viKA4
	GcZM6lPdwFj/hruQgbPPFcbsrgAHAjq1lXBuvHaUcX2XobYYjDClvlUZdxFsZLjVM494OfdV
X-Received: by 2002:a05:701b:231a:b0:11c:ec20:ea1f with SMTP id
 a92af1059eb24-1276ad1d358mr3834738c88.33.1772001051061; Tue, 24 Feb 2026
 22:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-fix_zero_wnd_fin-v2-0-a16677ea7cea@gmail.com> <20260224-fix_zero_wnd_fin-v2-2-a16677ea7cea@gmail.com>
In-Reply-To: <20260224-fix_zero_wnd_fin-v2-2-a16677ea7cea@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 24 Feb 2026 22:30:40 -0800
X-Gm-Features: AaiRm51e2CZwUqzIFBDbMqbi_sIUxJY_UyGodA_Qhpkt_frnps0K-W2qDHbOVCI
Message-ID: <CAAVpQUA8Bm8mATM+dt1bS5r_+krCfnGxd+Ut4rTxNCbF30HiZw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests/net: packetdrill: Verify acceptance
 of FIN packets when RWIN is 0
To: gmbnomis@gmail.com
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260775-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37522192612
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:20=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> Add a packetdrill test that verifies we accept bare FIN packets when
> the advertised receive window is zero.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

