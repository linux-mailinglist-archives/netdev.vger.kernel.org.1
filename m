Return-Path: <netdev+bounces-200805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B160AE6F52
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B689917F114
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E1626CE11;
	Tue, 24 Jun 2025 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="2RSihIXY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9824502E
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792485; cv=none; b=kAG1EznsliuzUPAhE53WjYby/fsTrXizJ9GppEKDBKKh3P7b6mtWLl+RZd2HzMaMdYZd2OJ7ndkqzfINNF6W7E3MFkQIIhOCNGhyOeNamyi+9TUFOc+0QXv2LDjP4K6mw3h6xTxVVBnjpVFaGqK9U6l2Z/n7LfQaJT2CazyGNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792485; c=relaxed/simple;
	bh=cK7invMTv+9Zp7Jn4wlj0VrbbXjyQPoL+BsvlYDJisg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=quSFet6zFiQRJRMsBVYjINPAktTkgloeH7hQ6jHptnq1vdOIFFGkbSqqIaw/lpP6N4iz6jYmwlX1f07PZi+mbCvRuFcX1vIw8b1qtOocvcByKhxitXZ9afZCzOROMeJI9n3lDxuaEx9Rb+zxfjYJc2KdCiNDmmfWa578OMOgQoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=2RSihIXY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade4679fba7so144583666b.2
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750792482; x=1751397282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i758Ky8oE7yqylYD7uxqKekAUdnnIo9/om6cPhIxexM=;
        b=2RSihIXYBaARMmmAJsJDzbRT0yLw4QdNW2T3Rsu92AEGdG7uhAPc1BYJnCDPPyAcRz
         G26wW71Ihexpl87JCL047vogM0cmt3fz/XOkUqlyhRDt1vsCl4cIX2lYJJDGVS7HJbAZ
         M0wkr8+CbSJzBrg2Lp8ySqOuPkfv8HVAPjEKrKZePn7supzsFiGA9e+yw2UCrP1DLvJl
         BOMxMe+WACJsgy1Mg18kZ61k4BmVAD4QnXxFgsvKBUzbjqd9K/PR/AqgL53vXzP6i8ex
         eCyJ47Gi+rigFro+n57xIjtywkhvdSYyKEEFeM4y45YpMz6So8NNxVFiBsIfYLlAXsz7
         hJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750792482; x=1751397282;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i758Ky8oE7yqylYD7uxqKekAUdnnIo9/om6cPhIxexM=;
        b=Od8mK7EPdpS9hipdHP+0q50HRLG7zAFfmvcfb030zxhzbSafpEvBAdIfTxl0rRlu1Q
         HiLgy2gJHGr3pH3BFa5UmgyXNzPquFFVz4uo9f85JLPm+HKYFB06FyNmUZXQkNU5XJxA
         MvJPTcyATh5rSCPnY/k6NrNEvtYbL3CYu1PqiD6nqkBXYoS3jmUgNwJFPmKhZatX2Hbi
         YcNMxjb7waxYyJk9rqR8tZCYZi0OqG6vcKN+mp0eME8yRjHmLk3SU0NmmjNvrP9IyZNB
         1X2YkBdBY6vCkFJvNCvGY4TSHaXHFvF2PoGXbEPSu8QbbOwgzgqJmKUH/glK2BQq+DX2
         TzYw==
X-Forwarded-Encrypted: i=1; AJvYcCX/T2nV+fByhibWw0uwLSSKFubqqkEmi1CfD995lIKqMLdk8Gt6GkDjkiJ7QUR3jbrha1XA+uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KImbf5wl4Pd/X8DVrPibRzq62caJI9blPHIh3bevYzfQdWy+
	lYgFGGTFx5i/KrafHpNChuVW3anowGLgMxKUj16Y1YAtpVFKx+sVjfYaGdPPURR4zg==
X-Gm-Gg: ASbGncuzMsTgj20zwI1mYalfjiiLUs3QZWH7LklyptAzPd+Wo4pDvrkdk9ZXjaJ1YpS
	o2V9/BG7Ssuwd4ZcUa0YibZQr+2CcTR62/JH+uCt6RToprMyA0uaVJvHQY2dB1XVUbi0RmLGXZF
	ns6oLypo3bpaxIJcC1jBKv0lEM446WcpGk+2/+fsMMV3tituW3S7F2W8LuONjvykkhcqkHJcbAc
	PUUPeHSbeU2GIZWyHVMZsT634LmZ7y5ZYTqbqRwG9LdO7mCq0SLlag6pK5dMqI6cYIAikBp67be
	HK2yDmPaSSwP8GguofkiBHzKlQMrsow2p8JtDS0cZyKK2YG+aqEY9g8qJziv4TaO
X-Google-Smtp-Source: AGHT+IGh+3ym/VJWtnmWq08iSJurV2ZoLlMoR+D33CMj9G53fcjK4wozO3Eitkg2sk8zbnY3++b52Q==
X-Received: by 2002:a17:907:9622:b0:add:ede0:b9d4 with SMTP id a640c23a62f3a-ae0beca03f0mr44977866b.0.1750792481952;
        Tue, 24 Jun 2025 12:14:41 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b5b764ecsm83597666b.5.2025.06.24.12.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 12:14:41 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <5c75ef9b-12f5-4923-aef8-01d6c998f0af@jacekk.info>
Date: Tue, 24 Jun 2025 21:14:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/2] e1000e: ignore factory-default checksum value on TGP
 platform
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vlad URSU <vlad@ursu.me>
References: <91030e0c-f55b-4b50-8265-2341dd515198@jacekk.info>
Content-Language: en-US
In-Reply-To: <91030e0c-f55b-4b50-8265-2341dd515198@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As described by Vitaly Lifshits:

> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> driver cannot perform checksum validation and correction. This means
> that all NVM images must leave the factory with correct checksum and
> checksum valid bit set.

Unfortunately some systems have left the factory with an empty checksum.
NVM is not modifiable on this platform, hence ignore checksum 0xFFFF on
Tiger Lake systems to work around this.

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Tested-by: Vlad URSU <vlad@ursu.me>
Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
Cc: stable@vger.kernel.org
---
v2: new check to fix yet another checksum issue
v2 -> v3: fix variable bein compared, drop u16 cast
 drivers/net/ethernet/intel/e1000e/defines.h | 3 +++
 drivers/net/ethernet/intel/e1000e/nvm.c     | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 8294a7c4f122..2dcf46080533 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -638,6 +638,9 @@
 /* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
 #define NVM_SUM                    0xBABA
 
+/* Factory-default checksum value */
+#define NVM_CHECKSUM_FACTORY_DEFAULT 0xFFFF
+
 /* PBA (printed board assembly) number words */
 #define NVM_PBA_OFFSET_0           8
 #define NVM_PBA_OFFSET_1           9
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index e609f4df86f4..56f2434bd00a 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -558,6 +558,11 @@ s32 e1000e_validate_nvm_checksum_generic(struct e1000_hw *hw)
 		checksum += nvm_data;
 	}
 
+	if (hw->mac.type == e1000_pch_tgp && nvm_data == NVM_CHECKSUM_FACTORY_DEFAULT) {
+		e_dbg("Factory-default NVM Checksum on TGP platform - ignoring\n");
+		return 0;
+	}
+
 	if (checksum != (u16)NVM_SUM) {
 		e_dbg("NVM Checksum Invalid\n");
 		return -E1000_ERR_NVM;
-- 
2.47.2

