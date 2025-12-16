Return-Path: <netdev+bounces-244947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D47CC3AAF
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DAA430169B4
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498AA33A9D3;
	Tue, 16 Dec 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJ9MC+No";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HI9DpcgF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947D63A1E6C
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895746; cv=none; b=WDl680D2rAECS6o/veJg8RSbAhQjx6yWZd1lUTc+fD9MSESnmLUXJwQoCrCBabmn9IAzYsF2a1D60b5m4q5Af2ox1U1TkLyThSDlEjoi+EC8gnaQNdHDL6ecRg1KBSKz9V8JIkGrnztiDrmQn+A0thwnLjd6DgS04UEec95iV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895746; c=relaxed/simple;
	bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbNvIWbn5bMy2MTi/OOLSkXdPXFbNJExe8ipOhHdeDQUvRMF2Taetj4RPVUFVx/UQelVcjFlaYeTifaJiSAw+4I8onMK6yRz+deSSwXf8f2evedMIcvmU2rYkwiDEWZmky9241CLnLzH9LKmffbt4bMl5Rb1iTubLXUxU6kwYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJ9MC+No; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HI9DpcgF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765895743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
	b=QJ9MC+NoH4FGxx/AfjEIX/r6BJ9oiHH5RU7W2BpTnib6LSR23WcE7ntuVBmRraUEX25277
	GKzNw90biS8eJVO07/8969YkL8TbvpJKZNcHUFjsJk+oWfgPGAj6d4PvQG9OMCEU47TpDj
	5YpalZnl3NWBxB8GQXXfTQ5+F2zGmnU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-Wxz8tr2uNXmxUfolnZ8_SQ-1; Tue, 16 Dec 2025 09:35:42 -0500
X-MC-Unique: Wxz8tr2uNXmxUfolnZ8_SQ-1
X-Mimecast-MFC-AGG-ID: Wxz8tr2uNXmxUfolnZ8_SQ_1765895741
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43102ac1da8so1128923f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 06:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765895741; x=1766500541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
        b=HI9DpcgFTcq7/oQoiFTFel4T/ubbksw5YSYskJwMcDLqPmqBc9CTvgqBYG6kiKoVwD
         g0fWPA2S2naqgi0gqI6EXx1y/uJNmkzZBUN6ulhQaw6kIeqQKVAszTshlaTiBt8uDZY1
         Lh0R4QDmL7P3ON4NjU/kPbimDrK8SzjdxDwDo9HC5684YzUqBG5xrxYCRqUQ7Vf6+ANx
         s+m1DzfIsj3N6CRJtj171bn4CTIl4j7gw9o+cbxhjYRHY1E9g7wZADuE9bxBsMzzIzSB
         78MqVqeY4E+ULfTPBm6uWxQTAkH/el7PdxfTBM7hR1XhnYfZAJ2cZ/4Ag9hcaPKAQM3x
         inYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765895741; x=1766500541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
        b=e9UBZ+EO4SWxAldC8gwQa8xlhUDtLEy3ZB4tnubQN1xKLHnHzEgHRBDbGEpSTVuOuL
         ypSmS/neYtkDeleCWLISRhRFoTaHB/9fFOmuB6Ly2WzE7j2Sw8LyQ6hDwdCrcuTtZse/
         C9Rq56v/BGOWTU2eGPL2MCilp59hg5w4hTb/4MnrrRmcGKBDHG1Cdgg+Nx8fy5L7BO0C
         ukbsI8ixHJy2oDUyPwnLa1Yq+CNWGkSw4fiqkUpJyE3vPGM9ljV1Rsy643RUr7vJiNQg
         37PXYqQeUtqxo/lKF2YHkWvDQJh9zo4n7k90+HpB/XL9d5MWHn/leqaQ7nDTTkbvEPqE
         dM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCULI55l20ob0pjzhHb52Nv3os+vALZh7JWoKEDc15GFM1dyBtRnwoXBxY7lCFSzcFuTcTDtHnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs0SzB68cS8uD597DgYjeYZC2vhfJ5E6TkHegMnjPWrk7/5o/X
	AuXUZ7cr92Elh7+4XVn3RVekofwrikggoYuQqoTQon8eEf014yg8zH6cXmzO/HiXEs8qri0k6SJ
	iayaaB90UMutji23YSf20GGudbjn42ZlNd9rpwOUnfdVhAbeBtKZuuuIG8A==
X-Gm-Gg: AY/fxX7shUC/pdwpzhgF5woOgfHij1c4K28E5mc4hrSvJQMAM6jB1UOOdexzbUKLQpq
	5kbB2qv3KqDR8t8em3AqgMFsaJQksAdqLzFgxgVvy5H5Ctpy6d/r4H6QPlTZoNZAi4sHSpAFQ70
	sB+uQ+QnoJFwSnbY5EmNP6owpeU5nVni40iSwJXArEY3CC3vQ8xVyPwy4GoRgwuUPK++6Vqk3UX
	UpXQWUO3eeLKkFUWwqvTf5uPJOfCTzHGBP/Tr8zg9OR+b8YxsAr4FJ8jeOsryjpdwukNTbVMTMa
	gu6ZaTUxq4F+xYgiZg2zjZeY4he7aX0zyxVGjxG/XX7fwaPe0Q+txKGHjs7Or9fCKRrV1yeihay
	hrehpMoFgGoJtZyydc1WsBVB/P1S1f414M3FAAaKxcVlipPN3s/iIDxzYlg==
X-Received: by 2002:a05:6000:178e:b0:430:f463:b6a7 with SMTP id ffacd0b85a97d-430f463b786mr10423858f8f.45.1765895741330;
        Tue, 16 Dec 2025 06:35:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEiQf6BBDsC38L/5VWuZcUazJwh3+kQd4Ox+qhR2hGcQAYTsyHnr0moIxAY07XF4YHlOkdZw==
X-Received: by 2002:a05:6000:178e:b0:430:f463:b6a7 with SMTP id ffacd0b85a97d-430f463b786mr10423822f8f.45.1765895740892;
        Tue, 16 Dec 2025 06:35:40 -0800 (PST)
Received: from air.bos2.lab (IGLD-80-230-108-89.inter.net.il. [80.230.108.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a09fbesm35964873f8f.0.2025.12.16.06.35.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Dec 2025 06:35:40 -0800 (PST)
From: Vitaly Grinberg <vgrinber@redhat.com>
To: grzegorz.nitka@intel.com
Cc: aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	przemyslaw.kitszel@intel.com
Subject: Re:[Intel-wired-lan] [PATCH v5 iwl-next] ice: add support for unmanaged DPLL on E830 NIC
Date: Tue, 16 Dec 2025 16:35:38 +0200
Message-ID: <20251216143538.14975-1-vgrinber@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20251120105208.2291441-1-grzegorz.nitka@intel.com>
References: <20251120105208.2291441-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will a notification be provided when the lock is re-acquired?

Another concern is the absence of periodical pin notifications. With the E810, users received the active pin notifications every 1 second. However, the unmanaged DPLL appears to lack this functionality. User implementations currently rely on these periodical notifications to derive the overall clock state, metrics and events from the phase offset. It seems that unmanaged DPLL users will be forced to support two distinct types of DPLLs: one that sends periodical pin notifications and one that does not. Crucially, this difference does not appear to be reflected in the device capabilities, meaning users cannot know in advance whether to expect these notifications.


