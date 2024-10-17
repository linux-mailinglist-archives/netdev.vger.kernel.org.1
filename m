Return-Path: <netdev+bounces-136767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3172B9A30AF
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 00:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D431F23758
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 22:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57601D7999;
	Thu, 17 Oct 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="xEyRLx3f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1DE1C3034
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 22:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204037; cv=none; b=GJ+gRI99yzvW1fR1FZuJg1aM/wrnZoUl2uNlKLqY0BOKL0E+cT9UOr0+3dCMS7rO4Eb9HcXKLZh5KatzugIHbksUcTWw5tv0q1m1fh9fSocCLnUaE2mWuZmMA2Kj4wRZc5JeWQNaXrz5rxEkFNoLG1TofEMJY8w2Qx8VFPB+OuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204037; c=relaxed/simple;
	bh=9ovJoxd3gEEBAx9LF4IdM/US2s9arr2XwaPwIXtKT1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0aG26z1QIhe0gEBUN6563voof6B33pxjYqjQFyXtkUt/5xwhokUk5X9zMLTxDKDZk1WLX50X0297uPWV1xeao0Y6E9dyoVNXuBpE4Wjonrpk8yfkzHB9gMzUcp+Oir0SU5tW02YNRzAw7xTZZpy3aiKY2ccf5PkHJtzflvdoKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=xEyRLx3f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-207115e3056so11732135ad.2
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 15:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1729204032; x=1729808832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEvyRCbBQ/qK6UOIsSyfJTPyZoT4uoi+TMsI7aMvmrQ=;
        b=xEyRLx3fhDqww9IlormgrWCOVAUU8hnKh50COFepOxWe6ho9XUs6cr7JQePjbaVS8Y
         cINX5vw8EoqohWJKh4DXFQEUgyBDe13jhNhQT7c6+/Bq2fQvmzpVXnjAA8Rc25TDeG16
         pFmlAG7q4S+WTWonY4iCCHyyn0X7y+DXf3svmEYwjZ/2NQlprO/DwirbCkEO5+Ag6kil
         stufb/8R0Fu631UnUv07/o4dayAuhO04nr5U3w+FlhUwpBb6ObuAjxztaLqfTbiBRAvr
         JbwHfbPpWEe3V/uDaJkCr8Xzc6+XV7/UY4ea4B8yk27TG5OtiOJq8E7CB+lUzVNpxFOK
         Xhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729204032; x=1729808832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEvyRCbBQ/qK6UOIsSyfJTPyZoT4uoi+TMsI7aMvmrQ=;
        b=lhiYr+/EB7ZjPKO5eFR9IrQccTvQfVXr0DR8gYFGjocjYnsDFGnc/wwHPL4cefguuD
         A+luxzGuIIND8R4HZYMEq65+zxk+BOgbKZUhCA6AwarPOzPkBcKSps4q/xO8nEBVmZ0l
         WGr3ea1G+KayMl/zcvNw8SNRi1RNFQCAcSlGGMbdTfdtnDIAQlEuRijQQZ0994wMht7q
         xLS7CyUtG7z9pMVINHH/BePV4DhOifwPWu2yXYo4IX5k0ec7vuHAm6+vYi89AZgziCVm
         YqaF9A56xYCxzBx5VAvcH6dJIY60MY9Zak90BV4QJJAHpPCmLGM+vPBZFe6DjBp/M5er
         RB1Q==
X-Gm-Message-State: AOJu0YyQCRhlmZ//1vyXMxbVvLWhJHFO0c1VMCyiCTrRv1slipACd2Aq
	Qy/HgapqqvCGNdGV268XkTWeUikHAXBvz8MtQ/NSsu3CWfSpBTVxg4kiv/u3Ol0=
X-Google-Smtp-Source: AGHT+IEzMh9BtYt3baqqixIYhJmNFAvJgtxZQXsEn70BcUBOII8/wnNagiyujMYX0T5vir/UIYU5RA==
X-Received: by 2002:a17:902:d4ca:b0:20c:f0dd:c408 with SMTP id d9443c01a7336-20e5a77401dmr6109125ad.20.1729204031676;
        Thu, 17 Oct 2024 15:27:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a90d911sm1243995ad.245.2024.10.17.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 15:27:11 -0700 (PDT)
Date: Thu, 17 Oct 2024 15:27:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: SCOTT FIELDS <Scott.Fields@kyndryl.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Support for JSON output in 'ss' command
Message-ID: <20241017152709.3bfab4e4@hermes.local>
In-Reply-To: <CY8PR14MB5931F3815D306862800B6A178A472@CY8PR14MB5931.namprd14.prod.outlook.com>
References: <CY8PR14MB5931F3815D306862800B6A178A472@CY8PR14MB5931.namprd14.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 20:49:05 +0000
SCOTT FIELDS <Scott.Fields@kyndryl.com> wrote:

> I've not seen any clear indication if there are plans to have a JSON output option for the 'ss' command.
> 
> I would be very interested in that option existing.
> 
> Scott Fields
> Kyndryl

It would be good to have, and the infrastructure is there in iproute;
but no one has take the time to the effort to incorporate it.
Patches will be reviewed if available.

