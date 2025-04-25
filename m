Return-Path: <netdev+bounces-186697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3AAAA0733
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C861B65A28
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F43F2BEC31;
	Tue, 29 Apr 2025 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6D8bXE7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF34A29DB69
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918842; cv=none; b=ZNlXYa72aGjh7DdmXpTguwIgMATGLCGSKerMHhORcqe8gyNrllYn2R/Vw9vAdesyDbWemnBTfTTVq3Imoet+AgS+xvp2Md7kfXV91P2+DqxTjbdA5itUEsOjxhp7GA8FQlG11Y39zSM+EN4JZPN73e7xBjKb9aRhd75og3yjlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918842; c=relaxed/simple;
	bh=kLRjNiluoNas4h4bvhSwmxt0aELWz0FkEpeln//B9w8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Bk4mTxH3mVIDArjQHxf5pCd1GEecSaOd2gT61lqpFpYls42qQ6EPs8LsQa3TORtkQsRGciT/bltPYVkxNVbjGdPVw1BXVSkGpgzI0D0/6h3jFqN/r/Rn4+B1XHfhTAklQ0RiCrW500gaGKFM8pjQhwoNaQycov/QNO3XuTv7fmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6D8bXE7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfe574976so39424915e9.1
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918839; x=1746523639; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLRjNiluoNas4h4bvhSwmxt0aELWz0FkEpeln//B9w8=;
        b=f6D8bXE7ET/ZqXVFehrfFmCdybmASE5lcT4ju+HnaryKFptAqzTm2KH0HQcm1JJr4u
         LyWqedXGQ/czGWBuoSaqQ58esswYBMiQRF2ZpUzzQbocQ/bL7oH69UXWRl6XUFBOqPJZ
         lHSOWDu4MmJjKbFYihdlhBTYOPktIKzhcrssI1HCQaEl0pUvGccpGwbtUaFjsFOrihha
         xWSqK4hnPWCttAEsHTe0R2VbqOo/j3MPszIbn7Ext63MHpbbOyFn3t453R5quZQlnThA
         OtCfDS8ykaQevH0jaOcbSPPUalYRZt/fK3wgAEl4tKSx5/tQzwG27sEFz9lrVK6lWyLl
         d0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918839; x=1746523639;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLRjNiluoNas4h4bvhSwmxt0aELWz0FkEpeln//B9w8=;
        b=dFQCQfTimhOnaFCSRS4+lk0WZKzXiJVSkfAxWPVVT1LzUdREplDi4s3ZHnpd3X6bVO
         tWOtRZQHuzNL7MAYsOL9AaBqNE1BWt1P1Lcjnxz9Ic/cz97xsdXAQRsYhZQRpX/s+rVK
         QjE0vNPZ6AMmyDitqvtbwLi82ljipoIlsKRqmD9Puc+uAmADK2JnpplUOgSk8d91MNcF
         wJIy65/GH6myzzMnnbt6+RSnsMOzRSOTGeJb/4Lg6kqvC2t23KrRuRnhUOUyY4Czs4uL
         H4zUUmPTmux7SwZLXr5fql/OdHs87CR7943f0ikdqr4oxQ7gpRl0udqnwv8Yu1zIuYgl
         ac2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdJug9mxvYeWiUTU3pegaQ9cVFKxTWDbhCnnzU8s7xbjJus4QFMuViNVFUHDAmRwmAvU+N1B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo92C1N4i3gf5h+kUVNOfmAFQ5LWJiAih0djCwttAeNf5s/01Y
	ge58ci41PuLPcIH5k1nRtJ1XmVsy7xrPxTbP0BLg/f+0CY0Zyn/l
X-Gm-Gg: ASbGncuKG/gYNRDoAbKTZKAbAlBuuOmndec3QWfPxXBzBwH+zqQLqOSdq2i5/kIBkYS
	KhGXpjTcjYtp4BhELoJ/l+An6BlDUto52OHckpDYLi1oZfcfcnqa1hDG9ZaxsIKd6KcFdqHzWz6
	zQQaJUDBvgIJspSQfjamVrdD0mQfN0lMHharYbmYhh5ETNRV/dJtA9NI/rE11N2SPC2i2uOZ+WN
	RjrtDM6EKrECX00PkGLh3m7dwK0akdV1y/Z/vIRnUpZZfhazyXAMi5StpinXJafLZdQq0p4p3+n
	P770dgZmZojHs6nSdw8kcMQXueHLJLFP52IfoKaUAo3qLx0eFnlzMg==
X-Google-Smtp-Source: AGHT+IEGhjeHUwEnoDXsqUot6aq4SKB5C/jx09NrCmhWY4UV6LVMrq7pxb2ViLWeWpuJRGzuMTv14g==
X-Received: by 2002:a05:600c:4ece:b0:43d:fa58:81d4 with SMTP id 5b1f17b1804b1-441ac91d66dmr18850725e9.33.1745918838724;
        Tue, 29 Apr 2025 02:27:18 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cbe386sm13220779f8f.42.2025.04.29.02.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:18 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jdamato@fastly.com
Subject: Re: [PATCH net-next v2 01/12] tools: ynl-gen: fix comment about
 nested struct dict
In-Reply-To: <20250425024311.1589323-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 24 Apr 2025 19:43:00 -0700")
Date: Fri, 25 Apr 2025 10:08:05 +0100
Message-ID: <m2bjsksj62.fsf@gmail.com>
References: <20250425024311.1589323-1-kuba@kernel.org>
	<20250425024311.1589323-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The dict stores struct objects (of class Struct), not just
> a trivial set with directions.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

