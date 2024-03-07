Return-Path: <netdev+bounces-78537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8463287595D
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 22:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C261C2367D
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 21:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC11A1428E5;
	Thu,  7 Mar 2024 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AKkqhXbF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DA4142916
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847014; cv=none; b=eKqEGevyrhwOzr0nv3ro3rgIOC9gQrnrHil+WIZ6kxkUyQIkrnGiXhSdAAv3LUjAPh18IVLh8yfvZc0B49RoqhEKhVLZH/9Ze789eOeuBijwXvrAlEXU13gtIlsnJ0uPP3YcNS7yZOscRKjFrwn2PlFPcywxUippH5MtwvTJvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847014; c=relaxed/simple;
	bh=qvYXdrNVu5d+kSNUXx5DBFt3PF9WPQIw0ynJtHs7eEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YA2d3ZcSpZyq6/B6nZm4fpr69xcMGZ+O1p7y7tMs1bJhVkR0dC0Gs3XroqeqrycVybXeMrozawle8RywuZcbYepM+SRLUCMc4Z9YC9vxH3i2n14wTp3kydyMzyp+YOjIlbvJt4ZbgYu0QP7Ga4HR8XOjwiLz2bR0nVbPRoAl8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AKkqhXbF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29ae4c7da02so151959a91.2
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 13:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709847013; x=1710451813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wTvrBoMRxZCWaEX/3Staq0bbOJFHnuwbRWeayyXP6g=;
        b=AKkqhXbFpQVyWjfbFoDIUji32kUZioL5jrRUHDGR6UtBFceXcgImT8tlwaqsDfr398
         4HbQQ8/ItpndELWV6XwVN7fJfsG2XPmC4zgPaK4YWjJAuyvhCajAkG0LcFrv5n3aHs5/
         LslWHANuy3bHp95Cw+MvZXR++kA9NOOc/q2oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847013; x=1710451813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wTvrBoMRxZCWaEX/3Staq0bbOJFHnuwbRWeayyXP6g=;
        b=NHiAwrGnuuLu96cRAml4raX+eH91/x9PbT/Epp/x99BKwYI+k88PmmOqTLyNJL7kV2
         JlbBN69TORqRQQxxiqJKRxSL0fHxWL/BMYiB6oDH84rjkQ2Bc4sRKbmKvIWzPN9R6oMq
         L31mYvSmdEdkoW6KNpxVeSkL5GK+7eZ+mOc0nq8cPatEskgupXHL/NUzXXU4AfY6ew80
         0L4fk1a8JgoBsMnCSVWCdT1vyztEKV6aRHQRZ5OH6NlzRKHbfcQHKll3WfEsVIZiNOm0
         zcEwtsn1yWowl0RuD9JpscO4kA80mRBKmZNp4B/oCdlIN501P2ALn25Hew43gioB6D5J
         rdrA==
X-Forwarded-Encrypted: i=1; AJvYcCUdo7IL2HsKNro2L5mKOVH+PllrVjyxduu6CN+ovkk+rQ3NRfISIgIYGkTMvFbLkoYFfhg9FYTmBRM8CifR76N2vtsSaxPc
X-Gm-Message-State: AOJu0YyOctUWAchmIF0AuMq/IM6i70p/2QCUGdDh/HzYWLtQsZOikINk
	A1GsfR9f7nYk1339nigdam0sldaCsBjYaVQZU3Ep6dzz1bDxiYT6Y/9jsQaI8A==
X-Google-Smtp-Source: AGHT+IFVrVN0tHcOVBFKPEnuhQVuezk1j0U7qfNAEn4QdWC6lbUljz3m5eFH1/rI7jdt8VRUi2xtVw==
X-Received: by 2002:a17:90a:8046:b0:29a:7efc:4720 with SMTP id e6-20020a17090a804600b0029a7efc4720mr16660957pjw.31.1709847012662;
        Thu, 07 Mar 2024 13:30:12 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([64.186.27.43])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090abd0c00b00299db19a81asm1991021pjr.56.2024.03.07.13.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:30:12 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	namit@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	jsipek@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: [PATCH v7 6/7] x86/vmware: Undefine VMWARE_HYPERCALL
Date: Thu,  7 Mar 2024 13:29:48 -0800
Message-Id: <20240307212949.4166120-7-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
References: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Makhalov <amakhalov@vmware.com>

No more direct use of VMWARE_HYPERCALL macro should be allowed.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
---
 arch/x86/include/asm/vmware.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 2ac87068184a..84a31f579a30 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -273,5 +273,6 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 }
 #undef VMW_BP_REG
 #undef VMW_BP_CONSTRAINT
+#undef VMWARE_HYPERCALL
 
 #endif
-- 
2.39.0


