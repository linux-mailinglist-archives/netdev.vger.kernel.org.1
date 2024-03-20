Return-Path: <netdev+bounces-80805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC49A88121C
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8FD1C22670
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CA04085F;
	Wed, 20 Mar 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RH6tDIoq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1278446D4
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940389; cv=none; b=Wj07Bpg5o/8YLyFtoDjC5TF8WL4s9sjgooag140FRM/sVRCWC4jZ/w3YXefite9a1EBz1DeaW16nI/asAF6tdKiYcutQhTxRfmQysJWR05beqZv8EIwo5giKiP7kgoOgO8m1+/8UeDUx1Xd9PmQpdc3EtE1/E4Ly6J5l3jXQVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940389; c=relaxed/simple;
	bh=2YDNxT0fhZocPvNupmzUSE6JHPXKV+e0KiJYW7C14PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLTJoq8FYtyBj5KxbzX/MaJDrHS+/absqiXdihoCD5L5iecMvGdoVsUOGeampOvx2q9wItbK31miIFzEeBDX6QNyvHn8+Oh2vQi6+cZ+KtLyZwmipQN4M7ykc8tAzF/M1eIIxB0GV4omXu2ZP3xndpxOw9BsV3ZjHV+Pc4OYLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RH6tDIoq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e17342ea7so3387471f8f.2
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710940384; x=1711545184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVomIyPH9mjZgwPoEk9ARj2Eibh5eoevRCgdrcw3zEs=;
        b=RH6tDIoqFk2GlSkPb4LZxoH5sjs5R0xVeBhqL2B7okGgmo8bUeAYJ532yYqZcfHyGJ
         sNMuIXV3Y0j4OidmhzynnEHLXMKIPu0hslFgbZrRoYViHy3bKYY6cSzcKjeg02hYj3S5
         Bl50X69E1uDoJT1WDyHPfHcI/KxQHj8CQJ/6QCxnTzbbOJvRAhFbp2cdzNm64M3c84yZ
         1ZVaBsbg4x5lQlt2kEZfhCc04wOT4NCRXHuQZX7neaC6R1D62D7s4oRA0wm2sM5KD5Rp
         nPDCakKzK/t8u9C8kS0N48vrbUdReJtsSS3cBCid5UC9EdKF2ZIdIVdIqmjsYZUurHlz
         P8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710940384; x=1711545184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVomIyPH9mjZgwPoEk9ARj2Eibh5eoevRCgdrcw3zEs=;
        b=Uj3CVmaFUtHbjH/Wqk7/f+yz+RcESZTi7XklNKRI//ZkrtSgfgrWb+xXONphRCbC6N
         uWwC03pwmzZwCirMbJuFhHWeNobA39o1I5vDtZOvt2Ps9CpHGdIwV1SO9GznBUY/lFG4
         +3438v8WoosOiZXKZRtY1q5wUGAUFheHmPFT5Qc69U10iw/bYdE7StV06IwfSLT3OPsv
         dq6bTqVDWb1Fe1loQENWHINV/6GHqvA1BwNmakJ2EYPqx5N7TLOaLy6l/0ObCuUJx825
         s7xrImbCyXbBMWK84qZlYJBfc0G9etxFFX7EJ01Jw8aOBhhwWS/V5PnULS1HSrB/cISx
         RP4A==
X-Forwarded-Encrypted: i=1; AJvYcCV+U3gh3Ck0CBagewsS2NSP4e/r8gg5LwRx1ZdynMdgaZ0VTjW0AZEIfpzCN1oaU/i1X+hQFJK54pT4rfe3Q+SnFzVN/edu
X-Gm-Message-State: AOJu0YyRoFjqdEepGJsd5/khwyz1IXCGzhD121IAdeEp9MYv2T8HG5tU
	MoX1Y9JvZyPNNijkCixIDgi38mo4T1YvPKb0PHUKvYwdAExcExWX2qttADxx8P8niNybl3+dmMJ
	K3ho=
X-Google-Smtp-Source: AGHT+IEKYx4D63ZHfOm4QFPXok7m8sXPR0OBPYwXLg4wRMPrUAqEwyfylZFpXVcd5ndRm06b2vV/BQ==
X-Received: by 2002:a5d:4747:0:b0:33e:7f65:e4f4 with SMTP id o7-20020a5d4747000000b0033e7f65e4f4mr12573236wrs.56.1710940384083;
        Wed, 20 Mar 2024 06:13:04 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id o23-20020a5d58d7000000b0033ec5ca5665sm14657545wrf.95.2024.03.20.06.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:13:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:13:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, jeremy@jcline.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com,
	syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com,
	syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] nfc: nci: Fix uninit-value in nci_dev_up and
 nci_ntf_packet
Message-ID: <Zfrg3iIw6Z1JS7sA@nanopsycho>
References: <20240320005412.905060-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320005412.905060-1-ryasuoka@redhat.com>

Wed, Mar 20, 2024 at 01:54:10AM CET, ryasuoka@redhat.com wrote:
>syzbot reported the following uninit-value access issue [1][2]:
>
>nci_rx_work() parses and processes received packet. When the payload
>length is zero, each message type handler reads uninitialized payload
>and KMSAN detects this issue. The receipt of a packet with a zero-size
>payload is considered unexpected, and therefore, such packets should be
>silently discarded.
>
>This patch resolved this issue by checking payload size before calling
>each message type handler codes.

Nit. Instead of talking about "this patch" in this patch description,
you should use imperative mood to tell the codebase what to do.

https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes


Patch looks ok.


>
>Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
>Reported-and-tested-by: syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
>Reported-and-tested-by: syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574 [1]
>Closes: https://syzkaller.appspot.com/bug?extid=29b5ca705d2e0f4a44d2 [2]
>Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>---
>
>v2
>- Fix typo in commit message
>- Remove Call Trace from commit message that syzbot reported. Make it
>  shorter than the previous version.
>- Check the payload length in earlier code path. And it can address
>  another reported syzbot bug too. [2]
>
>v1
>https://lore.kernel.org/all/20240312145658.417288-1-ryasuoka@redhat.com/
>
>
> net/nfc/nci/core.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
>index 6c9592d05120..f471fc54c6a1 100644
>--- a/net/nfc/nci/core.c
>+++ b/net/nfc/nci/core.c
>@@ -1512,6 +1512,11 @@ static void nci_rx_work(struct work_struct *work)
> 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
> 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
> 
>+		if (!nci_plen(skb->data)) {
>+			kfree_skb(skb);
>+			break;
>+		}
>+
> 		/* Process frame */
> 		switch (nci_mt(skb->data)) {
> 		case NCI_MT_RSP_PKT:
>-- 
>2.44.0
>
>

