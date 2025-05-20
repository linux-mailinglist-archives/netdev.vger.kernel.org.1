Return-Path: <netdev+bounces-191876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B83ABD84D
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5484A6588
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F83E1A08A4;
	Tue, 20 May 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pr6ofc9I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18DF19F461
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744846; cv=none; b=c3vVmzMILuuMnFXjHZQzo18oQo5OW4Ec4scVdsqJALNGfeQ+0+tYzLMZUUmPEYDEhZjGTi0OgaA1Z4MRas0gY4jE/lC4rBgiQvlSKyV0Sa6LGWkZhs0Ll1mjr59SvmfHK7HLQjh95pt10bK1PvBokaIuD6JC/eQsUKubFJT2Zfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744846; c=relaxed/simple;
	bh=6meBjLZrW7n3rXptyUEj6v2moPfM9jfxvitOSjrhDN0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eRu0QMhCA6BcDeRU+43drrbzXM0PtFKsJD3Mahm//Quhv/8UtjGIEUwGC7AwgDdT1tRRaR1nGsKRLTErYdqQXGyjCsVIRT3M/aCMRrNtX8RH2BPRUW8vkK2zx0qEqDU6gt1m6bQmBuPCnRviqmRXeQLBIPhbxanqY6JBanycvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pr6ofc9I; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-4e14e3870b4so2788914137.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 05:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747744843; x=1748349643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uH1lnXx1WfqtfrLa50q3rmlUUJ05SL/Jqi97ujf+x9Y=;
        b=pr6ofc9I3ofn05aTeH115OgzNyimVvxXD65qnWWJPK3z+3zrocjWUCV6GiGZSMLMI5
         CvtK6PFMxYUB0JZc21JOrwWXYqB0VNSnZlPKgCR9dqoxCGOVCSMbQZYEcPIzDSr9aMlo
         ZZIcYWhkmyo9751pV3ZS8PgnFIwpDnHWFqCOuFINTaNCu99blcKWVcxrut5i1HlXUgBz
         UeJXxihDwPZhHaGn9huY/2gmY+R4VnImfrsuX+kN4PdERmlV+LvMMzddoPpdIO7PWQ4p
         XpiyW82zOEt32I3p69wgljMLePAcBJzqMhWPqtyQeV7QNehC+K6uUw4ZI3Z+rWsPDXcC
         IJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747744843; x=1748349643;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uH1lnXx1WfqtfrLa50q3rmlUUJ05SL/Jqi97ujf+x9Y=;
        b=sFzGeTPv1ExNBuF6I6wRbN/3Lh6uycseZLLrQb7b2MRsSInDxtrrFO2E0tMoRXYiMZ
         YcUUO0svf5scwW13aesYHPeyvZVHImqV9Eigef0o+WKibCErHNuwjU9eEqh+XhzNl7d2
         vPINgM/xGSxI5skvukQDkdGciaL17Smzi4M7ts9X94ze+wCFygzy2IL/H+4A8lxlDUwA
         sdTkjpEZLZQ0MjWxMuw0Uj+7+wzOQ1rlBZiGqoO9x67EI7SQjg4rbb0vILX9o+9DOTYH
         C8FHm2n50sHT28VAo6burxqP9ZgUQyV7Te5wOTcBT4w0SOCr+hVI/vgkOPFq4lwMGH5k
         j0bA==
X-Forwarded-Encrypted: i=1; AJvYcCV5zvlVllXcGkkgZwNiGdOP7kJDE7gGZYo/TcHGhRFCT1V1J0TPGt1YFg/aejU+RcbmgMx/fS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztkZ6PrRW38Gd3Mu9AFPE1x1i9FLRuqUVab141mspKLE16xIgW
	A3w2KlL8LSJAfM0ahjxQf2Pd7mSn4trZbAx+SoV2knRquNtvE5rj41b76VXSNA29e5k85PRc1wC
	0bx6KCzX+ln1Qmw==
X-Google-Smtp-Source: AGHT+IFLCvMz/OrJGqxxdjYw2+dHIGYQDFY5N+ba0Mo58X824bHhAt0D7sfKz94naP4qwaTjJahhnBA3q4RzLg==
X-Received: from vsvd20.prod.google.com ([2002:a05:6102:1494:b0:4e1:4914:cdfe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4194:b0:4dd:b259:ef34 with SMTP id ada2fe7eead31-4dfa6bc2153mr14520029137.10.1747744832469;
 Tue, 20 May 2025 05:40:32 -0700 (PDT)
Date: Tue, 20 May 2025 12:40:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250520124030.1983936-1-edumazet@google.com>
Subject: [PATCH net] idpf: fix idpf_vport_splitq_napi_poll()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Peter Newman <peternewman@google.com>, 
	Joshua Hay <joshua.a.hay@intel.com>, Alan Brady <alan.brady@intel.com>, 
	Madhu Chittim <madhu.chittim@intel.com>, Phani Burra <phani.r.burra@intel.com>, 
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Content-Type: text/plain; charset="UTF-8"

idpf_vport_splitq_napi_poll() can incorrectly return @budget
after napi_complete_done() has been called.

This violates NAPI rules, because after napi_complete_done(),
current thread lost napi ownership.

Move the test against POLL_MODE before the napi_complete_done().

Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
Reported-by: Peter Newman <peternewman@google.com>
Closes: https://lore.kernel.org/netdev/20250520121908.1805732-1-edumazet@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Joshua Hay <joshua.a.hay@intel.com>
Cc: Alan Brady <alan.brady@intel.com>
Cc: Madhu Chittim <madhu.chittim@intel.com>
Cc: Phani Burra <phani.r.burra@intel.com>
Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index bdf52cef3891b8ff1d919b7024d42d024299215e..2d5f5c9f91ce1ef331e577848d91b0d130dcce8c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4025,6 +4025,14 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
 		return budget;
 	}
 
+	/* Switch to poll mode in the tear-down path after sending disable
+	 * queues virtchnl message, as the interrupts will be disabled after
+	 * that.
+	 */
+	if (unlikely(q_vector->num_txq && idpf_queue_has(POLL_MODE,
+							 q_vector->tx[0])))
+		return budget;
+
 	work_done = min_t(int, work_done, budget - 1);
 
 	/* Exit the polling mode, but don't re-enable interrupts if stack might
@@ -4035,15 +4043,7 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
 	else
 		idpf_vport_intr_set_wb_on_itr(q_vector);
 
-	/* Switch to poll mode in the tear-down path after sending disable
-	 * queues virtchnl message, as the interrupts will be disabled after
-	 * that
-	 */
-	if (unlikely(q_vector->num_txq && idpf_queue_has(POLL_MODE,
-							 q_vector->tx[0])))
-		return budget;
-	else
-		return work_done;
+	return work_done;
 }
 
 /**
-- 
2.49.0.1101.gccaa498523-goog


