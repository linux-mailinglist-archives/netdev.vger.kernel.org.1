Return-Path: <netdev+bounces-246641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD6FCEFBFF
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 08:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749CB300C5ED
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 07:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF951D432D;
	Sat,  3 Jan 2026 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQFaiUqW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0496213B293
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767425124; cv=none; b=jwDGSVcOVj00ja1X9M08t2eyAzUxyLf1bfJ2GCUQ6gDaWeE20iXh85qLSaF3JD2yiOcq9O4TIBHDa7eGlskTxIQ2r0v7ccMSoIQLfl0140a1KKS0kAaPVqPAUVNmkaraGaWHeY2M0pI58gScNiqzcvnjuteLEt1Qeur4z0A+paM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767425124; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XxNJBNWvlH1F6OdIKN9LoSzxDJMGyDzfkFo6jQ6HRFx9r5+TaR93Qx7PSphfX04gLonajiPrw1jhlLd3FtMgboC/pH6SfvvvvgvmlvsxGlebNDxLthT5YH+iTpIQ3eQ37mLiOtNd+/V4tZOFkpA6TGYl5Wifajoyw81Xhplrz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQFaiUqW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so13336481a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 23:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767425122; x=1768029922; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=DQFaiUqWL8kbtVxYYNtXZsFirTeywW+UcBh4+TLcdh/KMmanVRSa638bfX3AWW3qP2
         5J+m1+odcq2k/DuSc0d4zxjRERXNLjlh8LGCTuUkAB9m9z7Anm/92I5QhHr6kCSWkda7
         /pghcYa2gMfKyUawUj6hYlqmsPO5kx6FrHH4TdnqjqsgrT/CgLtAVHC6hYQLlMhsnD0n
         04Ooe1mUyvBEKuV1d9ceRJ8HAFsB8pjGScjcuflEdTM6e+frh9dIGkRAaBAp7E3LGoAe
         FhDLFSXBVAOguVCj5n52SFQZ8SrsKPWHQaak+lNL4VmPnIzmSnOgu5kHy5/E4e7rQq/q
         2bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767425122; x=1768029922;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=w4POli6Oo6YTXAR1HSXuzubZq/D66eLfLJZP1rJ/4yXX4NTxzA7GHR8Hdb4fjv0s4i
         VQdUaBHN9ahdX2yi0piDXID0pxppZFZCmBjEAMWYp39OCOs0wgZFe2tyMZYB0HSLKwqE
         q/Jd5rftY63gi53x+FxT6Qjxqn1FALZzpptxiC80BSNt8fQLSELL+V9ORt3zfy6JEfVT
         IDU/+HwBHm2UbmlXsbvidWLYila3VV5p5ObR01GpS31xF9hISEsC/0US7jMIxDOEW/kM
         FmkFIFAf8KQxCTyP2nT9K8UEfAQq3KBu3zY+XzE35qQkriPNmOKA0jslkVHv2e8Pd8BP
         KjPQ==
X-Gm-Message-State: AOJu0YyYJ+F7anKHFrNt2OdHqlA17JqnrmS0NjoRVSNjrHCYSZLSknJv
	gU4FhXAxXPr8HO0HpmAuqQJqBhgaLdbdbUxLe43dtJ1xuI0HEIW/ZHYZvpEAQ2+T
X-Gm-Gg: AY/fxX6LP/42CSIFlsof5I/LwYcdgAveoLFcQkk+69eT/fJKHOnwPKuBkmsWDOICHPE
	MSIHFcVBl5Bso+8Bzwt4LuAPMt54TEFnsHVtPPfoPIqfAJRbzkkrxWzwabqNUC1rnyjIuwmnC5C
	jOhc0Q0S9cfkc+brwcTR6Vnq92agUPgyABhBlJXg/FrTyw3+7ztafwppQPdk45gyZsAcbzQWLvk
	Z1/dG8TtB9kyPQUn5kM/Wloj8UywnhpJrNG3L/b5eqgmBkTjQCUBqbbXMdTnG97a+16rqT2Rg9T
	L0J6F3ggfn36sJi0PAbE6HxyqmTzg8QBwDnez4Tvw4XnMIymokD0p09yV5fl6+PltOPYBLH134/
	8wyGkEGj2sk3FQSGkndCc3CgpWDiKaBXzUT49RIL9rGk9gXkpge+yADq48Heppov/rJ/16EvLtf
	k=
X-Google-Smtp-Source: AGHT+IGF512wk+BSK7avmgBrxDWMCGzXsi4Dt5FHCN10qPjhP2KUxfWdkMemO0ovYtCh0mAITQvjLA==
X-Received: by 2002:a05:7022:6194:b0:119:e56b:c73e with SMTP id a92af1059eb24-121722a600amr54225545c88.3.1767425121689;
        Fri, 02 Jan 2026 23:25:21 -0800 (PST)
Received: from fedora ([67.63.80.232])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c058sm162279989c88.11.2026.01.02.23.25.21
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 23:25:21 -0800 (PST)
Date: Sat, 3 Jan 2026 02:25:19 -0500
From: Brandon Durepo <bdurepo@gmail.com>
To: netdev@vger.kernel.org
Subject: subscribe
Message-ID: <aVjEX4VurVMGLUL7@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

subscribe

