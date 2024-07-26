Return-Path: <netdev+bounces-113160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCED193CF3B
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 10:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88AD4282A9E
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D866178364;
	Fri, 26 Jul 2024 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RRFql49r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB16176ADC
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981097; cv=none; b=KKQSZPM2XX/RnkcGXg9BwiV0MPhEoCwj7sPv8w4jh9f1VLNngtsYabPtsABHHYfUkQJd9Fgmgz0F6GR36ZHdIoj13kJr+X45qECba2YhatAwZr9yZXwc0IvEdDCRk54F9opGTHfbwF4uuEmIhnnl7WrAIqlbua0os2EaMa/08b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981097; c=relaxed/simple;
	bh=TYWIXrzkXVZZkZdz/QrKdM2ifv+qqqsEjLpzrowXvkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PlKJKHKXyQFEqTIktV8GnRYC+LlO1k/6RYeaUBTB4RcbQEZIk70JKClK1mHXYEvV5scT5gjbJrYNWZuwTwjXffi7UQZ+PSZTynNutktc42TysdqHsTS13orqcaUNPQZ+WQEgrp3v5TLvlY6YIIunKj2IQlQphRXiUsAVNV/e24s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RRFql49r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fda7fa60a9so3833705ad.3
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 01:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721981095; x=1722585895; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TYWIXrzkXVZZkZdz/QrKdM2ifv+qqqsEjLpzrowXvkE=;
        b=RRFql49rFXFAqF4zve46pf3X2MbjA6hs/ZGlyUvjdtygs77+1bt3hfw56mkpKPGQ5s
         x5enAJ55pJXC8AP4yewyxAPhq1E73CZ0gRBJujtYGYTrKSzoD1z/vV7YihNiVfLB4Raf
         x/mFqnzjZWeG5LCHqWrTrHTxGmWJX2zQ+6SLUzI8pS3NMW0ev1n2yJWlv1EFhx+R7frw
         Hh94j3Xq+2YPI40RYgqC7QvrliVj5RntASc97Eb7dLYLsSnVgjVR05WvOzCJ69IH0J+L
         kEJ6c1vEfOH10Ysvg8LJV2Isi2qZI1jX0GqkmPwFnwoc9TOy5KWy4a6ZX4d6Xmx1WX24
         EoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721981095; x=1722585895;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYWIXrzkXVZZkZdz/QrKdM2ifv+qqqsEjLpzrowXvkE=;
        b=Wr0UjgBSuoR4piS30F7MqwHOek+QY+9qRKc/Jo5kuaAurQgNJBM56ec8XxbOSN97xC
         sYozSzwpv0PfoI0kon7plyzTckUwOSC4eGmGAqeLwQJODSJGl8O7nYLJZPumEbu9ORs5
         4LJvTJkJiE8/DArkibIYcUUN/drOuuZpyBSX9f6gCXs7c36gmGvASa7IzbkWFF18A5gN
         YvL5QG8ARexD3q9b21Irid+/+sRD0d0c6/vAbbHSAUimpWoDi/EOQlhKhDCFBguzcIi3
         uGeq2WcIp7hzRlFu2pF4D2e1QJJUnB8vEYmFbmd6DRLykkSCAtB1duqQjnWrIblAdX+d
         sNbw==
X-Forwarded-Encrypted: i=1; AJvYcCWsMjR1Wp1TsEG/VnHVXcX/NTliKXB0IVWjMIA4jB4qLL8o14OEfpVQ/QKmO5TVzkseO3XD+6TvSHOFbx6NMcg0C7LcVq/I
X-Gm-Message-State: AOJu0YwrHOiibzsQDSctTykEq/8P8uqNeQwmGIOe6agmLSPwQM9CRqw6
	N7wZUMLnmJSpBPyEkeg1S89fgWIb7DCUVTE+IInSFkr8qCiH3iDBnqFjxsURkZ8=
X-Google-Smtp-Source: AGHT+IEThCF8MbTWoYXIfCiu9y7Wa9LyskvBWhr5h/HfiuuzcdkiOmRFKdkB2FSE+F5WHhuVNo59Hw==
X-Received: by 2002:a17:902:f685:b0:1fd:9fd8:1b2f with SMTP id d9443c01a7336-1fed90b8c7amr55949925ad.8.1721981094597;
        Fri, 26 Jul 2024 01:04:54 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7d37b9asm26186495ad.114.2024.07.26.01.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 01:04:54 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: alex.williamson@redhat.com,
	bhelgaas@google.com,
	christophe.leroy@csgroup.eu,
	davem@davemloft.net,
	david.abdurachmanov@gmail.com,
	edumazet@google.com,
	ilpo.jarvinen@linux.intel.com,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com,
	mpe@ellerman.id.au,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	oohall@gmail.com,
	pabeni@redhat.com,
	pali@kernel.org,
	saeedm@nvidia.com,
	sr@denx.de,
	wilson@tuliptree.org
Subject: PCI: Work around PCIe link training failures
Date: Fri, 26 Jul 2024 02:04:46 -0600
Message-Id: <20240726080446.12375-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240724191830.4807-1-mattc@purestorage.com>
References: <20240724191830.4807-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 22 Jul 2024, Maciej W. Rozycki wrote:

> The main reason is it is believed that it is the downstream device
> causing the issue, and obviously you can't fetch its ID if you can't
> negotiate link so as to talk to it in the first place.

Have had some more time to look into this issue. So, I think the problem
with this change is that it is quite strict in its assumptions about what
it means when a device fails to train, but in an environment where hot-plug
is exercised frequently you are essentially bound have something interrupt
the link training. In the first case where we caught this problem our test
automation was doing some power cycle tortures on our endpoints. If you catch
the right timing the link will be forced down to Gen1 forever without some other
automation to recover you unless your device is the one single device in the
allowlist which had the hardware bug in the first place.

I wonder if we can come up with some kind of alternative.

- Matt

