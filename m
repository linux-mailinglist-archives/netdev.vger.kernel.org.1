Return-Path: <netdev+bounces-93878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710348BD72B
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D56C1C22D99
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F9615EFC7;
	Mon,  6 May 2024 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a4wN1GLZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865E15EFB3
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032436; cv=none; b=I+QiW83JfFLZJ5mbsjKruROH6theCLS2SDYM9dNa3DqBQxC/KWrqbpRukM1rx5Rfc4cQ3NTv8ffExkaY6a1Iu6HVhEgv++95JQdoqVD3lPHzADNA5hX0ouRF8kns2xbMxMPm4I2Fp0X1ug94Bel9axZjEhAb/JPJIBR0m9SPVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032436; c=relaxed/simple;
	bh=BTdB/bKcsgIg8SG05ME4z6NR7Hf/yomiKs5wTQl9JKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sqo+8JMlMpVA9khQ64aQ16XC0EdG2GkclRrmeCuXABW7D7OwBz88Abnf9kjCXwSr5+P6Qz3GqkvTibvBEACOJK7ZVJUZd4YCGBWpZi2ch/6/Jxoi0bLNZ6hHrvrtNGDWMUJcYbKjneZ6nqJILK8qJsNR+IG+qdPdgU4htC0Eomg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a4wN1GLZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ee12baa01cso10663105ad.0
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715032435; x=1715637235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fIJKpP9PuqIwYQVQAXhh3lvsNULoqRv8W6dHtBpvXk=;
        b=a4wN1GLZ0WdgTkEGGM6PKlK2FUKcjNwi/vBatFP51Qn3pYlnPXmXgCPlV6g4k5xzmN
         px/8Vf55cYGszQDh+phlc+otnTBUPJwEWCuiF3v/+o18ly4eimxMc4mBXOo60R8iCAKl
         ZfHSMytwvKsFNfx+QuGh7u5swww+QfzIE0H4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032435; x=1715637235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fIJKpP9PuqIwYQVQAXhh3lvsNULoqRv8W6dHtBpvXk=;
        b=nbiCxjvCHRxX/SQGkNj9TU64EgxmxU1Vy23XIZji3jiVedckD40xziz/Si5cc1+H+S
         qKIg6KxV88H9Z5WSyE7PZiAbZblHtR2Ok+sJ5RxZT4iEcUrRvBZzAREL3jj8k1XENnKZ
         /1YtCOiUDSZzwmFk7tgetty0gL8oeK30zZVfm+lL+9Xpms5vZKeZXPgSlNIEJGDaWtZg
         gII1i2ChDAgp+MoOs0s1jMb7npcvBb0dKuj0HbzcJa+8zl8gIP0KyYyfzDmh7Wbvf93d
         Y1IM/zypoAxF2ZNVTg/qkgkFbDmCswwpa3FM3yXLoPC3rX7kE8IgbthkmQp5VsayEBKO
         ZFXw==
X-Forwarded-Encrypted: i=1; AJvYcCXzzyKd71ZLCwd9iXUDOLZJ94Kq2zHD+XxWmWhpWB2dd6AP1qeSjhMIl0b2LKJVNfgXOn7FXqcMk9PPD0DV8Y0LffkqlyGk
X-Gm-Message-State: AOJu0YyOn2t26G0/2gz9A+Gz1LLIaHGx8G/BAMCyizG8wZk22IoIss5C
	LV89kpS3De7ei0+JD9e0OoSn/nzjUPLEps0AkE70FEvi7eb0MgrrN+lp8/1uFw==
X-Google-Smtp-Source: AGHT+IFyWv+jxb29t05zzSKDmxjDVEWVQ7r5yIdjW5CDcL456PzBbnI/9joeCaGDokUA59UoiPatEg==
X-Received: by 2002:a17:902:ea0b:b0:1e4:31e9:83ba with SMTP id s11-20020a170902ea0b00b001e431e983bamr13602030plg.1.1715032434870;
        Mon, 06 May 2024 14:53:54 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f54800b001ed6868e257sm5664008plf.123.2024.05.06.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:53:54 -0700 (PDT)
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
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v9 7/8] x86/vmware: Undefine VMWARE_HYPERCALL
Date: Mon,  6 May 2024 14:53:04 -0700
Message-Id: <20240506215305.30756-8-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240506215305.30756-1-alexey.makhalov@broadcom.com>
References: <20240505182829.GBZjfPzeEijTsBUth5@fat_crate.local>
 <20240506215305.30756-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No more direct use of VMWARE_HYPERCALL macro should be allowed.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
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


