Return-Path: <netdev+bounces-85046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA860899224
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 01:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA6B1C21668
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 23:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF2013C66C;
	Thu,  4 Apr 2024 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bGmB8WLM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED99130A7F
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273561; cv=none; b=iW2zBqoNT88lxJTNDcwigRdoSFGM8Z2QMMT3TXrgysx4ZtBVhm7mKtoMYsgAw3S9QqX26ND4P2XOzEgkAXUH2JTTe38TPxGlTCBXMcKKu4ktkOV5uNj3pZQqdnNmjj1SGd5xM9WuKPQCuUHAMbLUZXKKjR/6r7aUgJbTH9N3VTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273561; c=relaxed/simple;
	bh=R+JcGZWerA4/j0GP5BcYvILM9CMcZQ3Ab1BvbCrrzCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C66dA4PRX6WjGfI/ljnQm6PZldoiwXrJP6dxWWfJv8e6Xneig432h8US61n/tah9gwPR0c0XqMv6CD1TVhvnxWOmneIzejbVbpOQc5la28ILqo0deqJ/CSm+RaIvO6qeqnHni3QrmwlT+dpElw3DNg69erkblWWQdSTdVwo9KqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bGmB8WLM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e2bfac15c2so7561805ad.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712273559; x=1712878359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+JcGZWerA4/j0GP5BcYvILM9CMcZQ3Ab1BvbCrrzCs=;
        b=bGmB8WLMFMwpMjjvJzDIeeDDlejXxOtkjvpAhmt3k5cboS576t5rzSkQhcTDcfowSe
         gKymjunI/WKxZrVxk1qFg5J8RRC6fL+0gMa1anAy2C/LRM81kpB0MwoDIiOngb+mikN6
         qXO1fS1lymojlSHxowZYu6rjJdZbgOTlj3hAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712273559; x=1712878359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+JcGZWerA4/j0GP5BcYvILM9CMcZQ3Ab1BvbCrrzCs=;
        b=I3uyRUJoSUmz1P0nTkcvqKxBTnziQesJTbCqrdtWX7LIQTIb7xtCpvIL1tk60no3Un
         8XXt6hsf4CuguuGHI6xMMxr1goZGE5RuXPerP2O1sxAyA/8w+WQWksP5w3biISSGQOyC
         yhzYkt6S9AACzvaqi+Y79obKHmbotDQC/C/BgyRUlvQJxbINvfHXoY/esiiXTgwMJ03D
         1W62PYOAYXvbEMfPCThsAFXalNXaXcwaJ/BAhqOahK+z2I5z73Q/QL3HRMT7emjpCjSI
         fmiXIz1kquss9ymiYNjPDvi9kaRxCwSqCbTnqSgPEqccPI2kbjq6VDnPvIf8zm0zKI6n
         ZXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCURUR8k0V1Am9eUv/BuZUUJI+wl4W39zxupiqCsXZWhYE9GlAz1c/3/hvX2lJoaMdDPl5W6lSIuLx9TpcD7aWsa8RvaamUU
X-Gm-Message-State: AOJu0Yw4FHZwEA6wfY+afI5OKura9KKOxWtcMFYllvN5Jxw1y9hfyBMX
	tU+ouY/+5deqxJrxqMTulD/Id/6ovRWz+lYNCZo+9K5JlP8ofJfI05tnm3TqSb88sSsbBzoFtsQ
	zAQ==
X-Google-Smtp-Source: AGHT+IGG4uDv5A1Im5aEtkPraZjP1jqit8IkG6mPT5w+o0kvHdp78WkPTKabNTc/bYh7JTK+vQvnlQ==
X-Received: by 2002:a17:902:f7cb:b0:1e0:157a:846c with SMTP id h11-20020a170902f7cb00b001e0157a846cmr3031022plw.55.1712273559198;
        Thu, 04 Apr 2024 16:32:39 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001e2a4663179sm188177plc.258.2024.04.04.16.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 16:32:38 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de,
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
	kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v7 0/7] VMware hypercalls enhancements
Date: Thu,  4 Apr 2024 16:32:31 -0700
Message-Id: <20240404233231.36294-1-alexey.makhalov@broadcom.com>
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

Peter, can you please review version 7 of "x86/vmware: Add TDX hypercall support" patch.
It addresses the concern you had in previous version. Thanks.

