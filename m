Return-Path: <netdev+bounces-278718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHfmKu9P32nLRgAAu9opvQ
	(envelope-from <netdev+bounces-278718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:44:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2484021C3
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DCB13035603
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5F33D47A9;
	Wed, 15 Apr 2026 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVwjpQhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91123CA487
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776242666; cv=pass; b=m/7kWXZkgzPbi+bUCtWzjpCnRhWQ2YEbnir0mEuPiJABFnjWMCxV84K/i0w0hD5U89lwmiEJU4+D/BZEhSU1mbcicqkGt03x6K7A4sZ/6/T83AFa7Ur5HNLg7zJQ0Cpm+g025644AM0xVl8QktlorlYy7wFGllHowMRi0kvHpQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776242666; c=relaxed/simple;
	bh=Mp0Dhk0lYnbwO2gDSPWZreLqZBbZWgOEa+uBM9bOFwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/pxjIn28oM/llp3WwZERWfQ4Ty2QLYHtFVWMDP7ZZ4GzvSd55dcAEpgGwOkEmPwvRSkD1yMrFxKASCMckYmPcxCOBF7AUmo1S+3b6wN09N+7ipGH3YkqPuRf/+7jyUhtxvaBNaTOoJDi/6g03p77dOLPNuqi6fDAdfuVuV4MRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVwjpQhf; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a402dea4a5so2499485e87.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776242662; cv=none;
        d=google.com; s=arc-20240605;
        b=X7DZuFUWHLousaOxHMw1XjiwA9BlP9QapmeEiqP6fu72LKtn+9z+giAv5Yr7XyyOYM
         bC9XpPglsqkAfN0QhlpCBr0B6Qxqmp5JEX62Lb94aMboHrHcRK/rcDVLSo5cpJeGyQxR
         5qbvHHZgyFS6Qo+QUXm69iF3Xt7F+93xTxxS4gmB37QqGbMDdzQf5p7orLYrdsZdV+F5
         U08pvrKf1QuJ4UeZuQ5jPAj+4R64njl6T9c1DnrodtSCYGiqwZeVDOdyd70xvKDHQweP
         eOxknW+N052/cc7hUwbwsah+n+CKh2csqRatyNicPR0zuQXS/3eNf8nf5FivgxsQDd4F
         ACZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mp0Dhk0lYnbwO2gDSPWZreLqZBbZWgOEa+uBM9bOFwc=;
        fh=Mc28aEGU1iY4fjFSvUNGMSY8TAu2YkeOqwEgMw35Qt0=;
        b=N2LOneRbAS6C94cds2TtYbs3o2Y2PFjQl+1F9OIAPmQUs7kQf3xDBkmbPsE7mqwUQv
         qGSeFrE77Fehb8maipGHIgZhjs3lKih6e6c3QVE5YPpwp1ZLRlR6OuTPZ5RpboQW6Sep
         cnxRjx+4vE8BnHRejJSSAHaq3FVuXtIO65cnIqCaCtsR0n9g6maTNus3toQzyApcURPb
         NDDRQFHUJALP5eHwIt/PyB39L6LoGh77MNOpkhOAB/8zF1VhvJW7s4HZmrT6oMNcKyxL
         ErXV/59xpYCrQUl6LBps5O3qdP9gMc28sZ3WfBmH5tX9v+TTQZKpVk47TqIcPBeMx9Uv
         qpOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776242662; x=1776847462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp0Dhk0lYnbwO2gDSPWZreLqZBbZWgOEa+uBM9bOFwc=;
        b=OVwjpQhfrQJREJW7sgaaQuxPFZrLF/hPaKkuU/LHNcdBJYwPpEmdDzxQBxtsowUwCv
         JK+ZnAWl/Qw4IFqxvFxK8dSdfaemjWHnLA+5IZJ5IXPRh0/Ud4OxhMsy+jo1hhdTJ5Qe
         xIPxwGk8qoZGhXIfRdPSkGx6RNv9hgDbZcZIxUFz2fDNvY4zT2H69MC8i2AUbXPnZW9Q
         RB4i4YoOnn12FMZ8MJB+rsiEBAqTBinWkGJ3SXmrDk/MDxebU1rfFe4aqlW63CDBmQks
         LB/qFGiXJwsTPzJ9cncS/xuNE0XGWgjh63x3xpmj1XQkghpXaX7IbHKmFDDeeC/lW/T8
         qmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776242662; x=1776847462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mp0Dhk0lYnbwO2gDSPWZreLqZBbZWgOEa+uBM9bOFwc=;
        b=T325CyDG3QrppQz/AXePOesptF6vev35i+Z1DaQ7VHrE++FOMuZTGUygRPOO7MLlS1
         ziT5kCPZrtTHwHrUK+opiCZKR4X+F67YqvNzw7idfL7oi44yINm+Fdyk9fK7K24OEbjM
         0+9+zHgQADO+2hTO1A6kylZxQCVKbAcjyvKien5/dwu+goC9Ak8aYoP0MB6aNlVRiF1X
         Sss4mRtp0GK/Qn4HfViX73uBZClRTFLZZATXDaEBNCsy7IKe0jKDyybGr1CYhm8uplS6
         EGRcQj/s4U6GBHJdcoJx/wn8uW8p/+pMNA3JHTpCUAyBcKF3FbJ27mmF7xlVda6Zk+gM
         LoEg==
X-Forwarded-Encrypted: i=1; AFNElJ//LKOkjQjapyW6LAxu/Cv9QNSgh56nPZc0tApkbY7Vn6ITisUP6mT/ZMe5H9X0jGxCSHdugQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+B8cviquDXzlV1dpZQyFlsCk8esvx90FE4ss950f+OR10mlgJ
	Clw8ResuJNQtc/StvOl8Cha7GzLd2qF0+8Uh/Dqw2JNDwWTKZidAtOxTNSrcJH7qWyl4fis7812
	A+pSYAdAJGzv85Jlxk+U9ok7BeEWCDoM=
X-Gm-Gg: AeBDieumvY7IdBsfwR25azWC/9cDren7T6Y7vGU/Y0b2hMvYefOOWr91yjX+FF+UvUs
	3kBwj3kGJ6tjR6i502mcd5ksZlTVtrvW9jNMxF5qUN3dlIJ/KeUHkUnXo875BnnhCVriI7oMTyf
	tUUh8IlizNiNmrQYZqboxl1+tT/f8SjUHmnnCc51tr4S1orjpXqv3QbDeDoRV4R3frAtJENUCEM
	yeIaMhSkouy9nRXpe74N7ZNJf+xEvggd9JdxXEL2WLJNskTkrck3H8/8A5358ACX9tHnvXNVnDA
	LCSOnEdDOw6t7S42VJG/ATUGI3mYYw==
X-Received: by 2002:a05:6512:3c97:b0:5a2:c686:9ccc with SMTP id
 2adb3069b0e04-5a3efe95a7fmr7954372e87.43.1776242661492; Wed, 15 Apr 2026
 01:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774701288.git.linpu5433@gmail.com> <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
In-Reply-To: <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 15 Apr 2026 16:43:44 +0800
X-Gm-Features: AQROBzCt2wgsTaaBC9SpVkmhIZQ7-Is_FsZn4GXEUWW-Zwn2cocdtw-dm-HR96E
Message-ID: <CAL+tcoAy5WQRsL6z=YinPaiBNvd_=WB7qsR4amf1x4=qVw7AAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] xskmap: reject TX-only AF_XDP sockets
To: Linpu Yu <linpu5433@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bjorn@kernel.org, linux-kernel@vger.kernel.org, 
	yuantan098@gmail.com, yifanwucs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278718-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4D2484021C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 3:33=E2=80=AFAM Linpu Yu <linpu5433@gmail.com> wrot=
e:
>
> Reject TX-only AF_XDP sockets from XSKMAP updates. Redirected
> packets always enter the Rx path, where the kernel expects the
> selected socket to have an Rx ring. A TX-only socket can
> currently be inserted into an XSKMAP, and redirecting a packet
> to it crashes the kernel in xsk_generic_rcv().
>
> Keep TX-only AF_XDP sockets valid for pure Tx use, but prevent
> them from being published through XSKMAP.
>
> Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE=
_XSKMAP")
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
> Signed-off-by: Linpu Yu <linpu5433@gmail.com>

Hi Linpu,

Any plan to post a v2 with our questions resolved?

Thanks,
Jason

