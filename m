Return-Path: <netdev+bounces-197005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9148FAD74B5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9822B188562E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA901922D3;
	Thu, 12 Jun 2025 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clBW/dVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191E22318;
	Thu, 12 Jun 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739838; cv=none; b=Spc9iAmTZ2Nr+zShz23wK3lIX4/2fqOM5gl2ufZOQ5nHZAW68n0HjqZkUvVHCgwvcTixmnS0b+jhWm7XASIMFCPwpKfIh7ytA/pj8OVdd8vr9igtTseWVzZVDKPGY/T+uMTAtiOuxVCexYk9ryb7XbqGLYstXGE1DfLUIxjgXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739838; c=relaxed/simple;
	bh=D9C+xwp3mD/7d0f06D4jPqB+wkdk0j3g2h2HOi1HAbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6q/H9m5zGPJDaY+CLdeWGctvMmNEd1ah/PjBy6ZQLJzTGVGAKWC7KqojMluENv+SFiUyUOaH96ozEf5NjQOiSrc3ybq0CSMnja+Kh48aw8M1PoBL54SkZIpOQtEFDnlV35Esuj7ed4OIHtX0NhYu08jwE80DYKqaYV4msNy6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clBW/dVK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6084dfb4cd5so3836510a12.0;
        Thu, 12 Jun 2025 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749739834; x=1750344634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRXKs4VGDh5S2vPlr4/hDjovefGwIy/vQJKlAAiyucM=;
        b=clBW/dVKQJzm1xG59YQZgwa/4ot7SsigqvW5nfim+ys+GcVsJ+AXNMsLIRlnYHDjrt
         m7e89fGv4N+aEYiYAqndEdeekow59gTlPjkhDu7EPbLhLfAJHLjlENUwLvd8rxeJirEb
         8hnSQRa0olzwWU2QJct4jWM5mBcb0aQze2YPFMusvjV3SxmBVDTamFdb3W34pZgWibjL
         VhBA3iO212k2Srdv9ARvnaPJdEumWuBNG2vu6m50Ao31IWfwBt2qA9UttSjsxYRQf6AK
         hPJKbjB1BcG57Yv9I7ONFXXy1LCPsLgw98xQOkL3dhy9I9nOi6R1uKzTm0TTsn+DYzd1
         D74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749739834; x=1750344634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRXKs4VGDh5S2vPlr4/hDjovefGwIy/vQJKlAAiyucM=;
        b=Z9qkghbZ6gccb8/8SM+wuvouQA636ba4h26csto8VUjaiTy+i6KeAKrvFRZTibvSDD
         Izc9eR/Q43NEyPoIXXdlDzukhBK0qWW2zIGlor5SIlN2MNmjRtszyKJYVi1QwQm97yaN
         xdI7vxstww2s923v0JKdhD1b7tiRs+RdkKiey9xfKnzh7uxkbLvnNKxcayVBU1u3XE2q
         oRF8G9xR0hxefuPpdL+UlIPREbfMeIHIE+3bQCCANdwnsiYjPJ13pz4CsTJWrVz9mXC+
         2OUZrmIaWejKxoYvbAKX0cBYiF0vRH+01YjawaFPTfFcHeRgCrOF0OBwnsWYMNqx2An4
         vH/A==
X-Forwarded-Encrypted: i=1; AJvYcCVuusFVH/ngH9nnUXV2Sl9ObvzhER2+NyO9yEg5gotX0OOsI4+zulpIR0mFuGOLNPmbsRicGG2qaaMLKAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz92iOYL3znNf7XkQROOm7P0mXrZ2U29g8ZxFrrTjMf2ebo+5nd
	l92TfZPKoWqwJEZB5HKrzS9If3Z+L77uWQkC8J+RHO5QCLuQXK2Alw2z5uvEN/m/
X-Gm-Gg: ASbGnctHPHCFnihP3j5+Rho0pnH6Ckuy7CbRyn718rxE43sPpf5twimAuV2+nBItDG/
	X61zZbpo8d7PnZQ0dvdiUvQHWOPM8pHuZGzW1QyfpsHX49mEOcRxVuFeXWxESjF5ocbqOG5eGU+
	cIXw+w7VvFJomYD+Mv6UGuUzY4xILFtMyQFH2PZgFFDQb8E9m2rHKFOeBsnX1W9eohAp58ClHs+
	Sb/7TM8KdAUGNZZ6+wy8/PlpY7ZJSx21BI7d2shwZADj+91wYEb9F4p9fOmfE+gCTLj0cacEic1
	Xrbz95xkOSdNGhDXMJ6ChFwl8nrhcTTJACYU+SUJHZwl3fG0+RP+DYDYQMhsZ8SN2v0IEk+4lMV
	UYH2K0/Q=
X-Google-Smtp-Source: AGHT+IE6yt33Qixhwf2CvlRwXrUM91B/lNFVnf2cPUVd6bgWUieYAI6gxD+gQmh8m7XSxgF9h3kmTg==
X-Received: by 2002:a17:906:7307:b0:aca:d29e:53f1 with SMTP id a640c23a62f3a-adea56302bdmr374648966b.12.1749739833928;
        Thu, 12 Jun 2025 07:50:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3030:ae0:54e3:8eed:b526:85ff:7c72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adead4cfe60sm145009266b.23.2025.06.12.07.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 07:50:33 -0700 (PDT)
From: RubenKelevra <rubenkelevra@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	RubenKelevra <rubenkelevra@gmail.com>
Subject: [PATCH net-next v2] net: pfcp: fix typo in message_priority field name
Date: Thu, 12 Jun 2025 16:50:12 +0200
Message-ID: <20250612145012.185321-1-rubenkelevra@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610160612.268612-1-rubenkelevra@gmail.com>
References: <20250610160612.268612-1-rubenkelevra@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The field is spelled “message_priprity” in the big-endian bit-field
definition.  Nothing in-tree currently references the member, so the
typo does not break kernel builds, but it is clearly incorrect and
confuses out-of-tree code.

Signed-off-by: RubenKelevra <rubenkelevra@gmail.com>
---
 include/net/pfcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/pfcp.h b/include/net/pfcp.h
index af14f970b80e1..639553797d3e4 100644
--- a/include/net/pfcp.h
+++ b/include/net/pfcp.h
@@ -45,7 +45,7 @@ struct pfcphdr_session {
 		reserved:4;
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	u8	reserved:4,
-		message_priprity:4;
+		message_priority:4;
 #else
 #error "Please fix <asm/byteorder>"
 #endif
-- 
2.49.0


