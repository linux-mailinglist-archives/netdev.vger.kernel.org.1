Return-Path: <netdev+bounces-129620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78C9984C83
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 23:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250AF1C20B5D
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 21:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3152313AA31;
	Tue, 24 Sep 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K/swazZa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C21BC3F
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212008; cv=none; b=M/+9rO25iwSVMcOabyvdI5rP8WDD3vLtAxC4OsVw+pV/rzFXukVOh33PLfMevLm7vPgiw+mCUzA+jvBqcjh39855dSqU+Frxv83mku5mjY8p53q1NwAnNGvFoZXJrFJ+miuS9iB7zFO2gsjGbpNL92dsNwg4auZrQnA0wni3hEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212008; c=relaxed/simple;
	bh=duiQhgIpdYt0fr4EBf9j6/V+Y6v9sOYJHzZbM3O7qyM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nh3mB1K+8UBmL0v4ahoiyqlCAnJ8uTGB5fvfaFwN6Ei9GFq5VYbC9qtFhBSbiQW+2CDyvUqC+a5U5t0ZGdQ1LLfPMlC8xquOPCl/KHYcboU5Wa+0IOZa4dxkDazyAO+xpAoo0BWrF2KrZleh+vZxXFVNQnpAo+//3D5aULZ63qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K/swazZa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2057835395aso68808595ad.3
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 14:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727212006; x=1727816806; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cOSRCTldnYmAEoOT+PgzbC1WcHMLOlX9r7cKBA/cm4=;
        b=K/swazZayGJF0QHOQE6+Mez6T9gYG9QHzroTdf0lTHntyOnk3wU96kHtmjDfAwT37e
         YWsmflDkRx9tpv2Gy45CDWWJH9RNB84P5zo1ZauGsfFIvoEYFXTOa8063+0AadGb9/rZ
         TnLW5+CmLFgAHWIHh1LqoE6VWM595Ga89c1Ta0f2CEjL0FanhF4VAReP31nfCoXB/P5F
         ea/dSpLXaBABKjWYQIe5n87dgYQEHf2tObd9OzL7MprjAyXY/FhfIf6YG7d8tr3LXBBv
         0t6VAfV6D/MFEPMMs3dlLUsvLkWAioKCSv4hX+fb6UNWwca+CFdSRmNg3H9RiuL775Sf
         8EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212006; x=1727816806;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cOSRCTldnYmAEoOT+PgzbC1WcHMLOlX9r7cKBA/cm4=;
        b=mv2gQe/5eUNvRo6vC8at66XcXoxlxonvD8Xl1i31hpHBUhULVhHzMJ/crQyNpCCOy7
         wPZm1EYU7NTwEyS+7ZdVBdmEzPVFdyVE3rnnYavx7p33fUPTGcj4TYzGLgSIczk81mwn
         B2vckRoQXObKkHFvcjb+ubkSq/FtJHkqRFuaRIW+JFntC0a6DRdPEBH+iIFvcsF/8Qo6
         Y6AhRbPgXferI6hU2VYYJxlBykGB8GDcvM701lJz2QkDcROXgwTXbXAVAd6ydpyUeBxk
         iRafI8emRNMM6ELYJLuGtUiwZk35+ic41hZLEIU4cU5TXaHbQzArvw3mjwysQgBr5iqV
         BgVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB+6D7EnHI6F+SWPqVp148ahNkncFaH1LX3jnTA1abdO16ojKb4rZWbKEpz/sIl9TxpGri3po=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiRZRThaOVK9hpflA2TMfxbrM/PUGiicpc7LcjJbhx8qgHuXGk
	cX2Q8NXc/unTCzxSdkImhsoknyRppztS/Oz31c9D9XTEeFOQB1EL40/UWtMYpM8=
X-Google-Smtp-Source: AGHT+IGhyzhT4ItbLkXqJFOEF/QVw8PfECiY10lnETHANlsD8HmM/Se5SFVUhHSAQcwZL7gQfWEuoA==
X-Received: by 2002:a17:902:f60c:b0:205:826e:6a13 with SMTP id d9443c01a7336-20afc5f07damr7240965ad.54.1727212005646;
        Tue, 24 Sep 2024 14:06:45 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20af1818f69sm13717095ad.184.2024.09.24.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 14:06:45 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Simon Horman <horms@kernel.org>,
	Ying Hsu <yinghsu@chromium.org>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] igb: Do not bring the device up after non-fatal error
Date: Tue, 24 Sep 2024 15:06:00 -0600
Message-Id: <20240924210604.123175-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Changes:
- Changed dev_info() to dev_dbg() as suggested.

v1: https://lore.kernel.org/all/20240923212218.116979-1-mkhalfella@purestorage.com/

Mohamed Khalfella (1):
  igb: Do not bring the device up after non-fatal error

 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.45.2


