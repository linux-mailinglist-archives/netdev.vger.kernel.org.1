Return-Path: <netdev+bounces-99162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6268D3E27
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB7A1C23391
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC45139588;
	Wed, 29 May 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="jVoiZzAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42BB15B562
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006327; cv=none; b=BfgDptjz482HLQhz+PP2sJVn9YUMSAIBPBIajtRmmiGdf/ipBnasy8cZc0X2hAv1cseGpVGfFNNnAsV7TwoZ45algWe+3u/BNH9upLPFjEkseWT2+QQO9DDhrz0kmxmCFBYwSTx0nX2wTNpeiEo9lkkMdgSJ+Phkpi5eVHrBH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006327; c=relaxed/simple;
	bh=Vcw+wAOJgoRM41JcaaY9eoFw5GW4lHgGjbZD7AkIFzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdUNJUkWXZThU5OggihZvLl3Htg2CsaA08hAgfSgvnCth66TGGEXxRpFnDACjbSB2jTwH8u9W7QnZ6D9cSw4NOLwYHp5DXpONBHNtq1y+66pswVYC9jMGapkzKNoo1J4vqg5bdjQNRSi15L4b84OyA4/zVwzQVQvmjGb+3ZrxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=jVoiZzAb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f850ff30c0so42105b3a.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1717006325; x=1717611125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJ1CLPvbA+fzGbl0jg+dl0YfRR5r2pyfirOjq07UCJQ=;
        b=jVoiZzAb5BBIIfn4h0Idyp0urbNiyXDGEya87ull/Ji4/st+28IlZUZ02TT5EEL+a6
         0soSC+oSSGaTMTRmVlW2dnn+TSrQ9l0Q+9A7TJ45Gbhmk/zg+9B3HzdtTHzckappi+fY
         T6LmlDK95ZZaIrhpc6sMsc1gMcZOsVQ8RwvoJrSaI3GPURTkkjUEC7gcjIK/rIUwUNNS
         S/wiDq38u5dSTrJEzHPdkCZCu4m/YtT92g6Akz4hkq17X+br2sA3tS/gIxkUHYIjdx35
         74VDDZPHTxQ7Giv/K+ZIc3FcssFMsukGn5g5sR97aY4YJV5CEPTYs2Qt0AZgYCWEPpLT
         cURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717006325; x=1717611125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJ1CLPvbA+fzGbl0jg+dl0YfRR5r2pyfirOjq07UCJQ=;
        b=TpRrdtBZstzY11KnBkmSihVcz9RyLMp7CysQBeGl0sio4CM9B+FipZLkGO3hlwWiS5
         X7uyaN5S3S54XYxtvYTSJOKh6zV3bo+41a2ZfCnO47smkhDgYTWNnUMLgOJv2zkCP8pF
         uWlEOpZOSS+rC06uRKzbA59EnuWAe+4JeXumzjqEmdy0XUxtTpWVcqpEyWPFjehEqf1m
         BLQzL2ZlGSq/KCyUNra24bcXESMlYKANwM0EilN7UtPSsEN9XANb7jFyvrrqOVuvl/66
         4Qfs0eK92oOz9FmvNPXfjNe8nQJDGHK8CIRs+bg2y+TXZis+WYYKutQxhAXFbHf91Pg1
         zj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAr7+U9F2z00IO9GtvuizzP46TLjAQku6Q/EnuoErmAqnUhjEE/8pLGaCg7/kuTuydN2+5zGEzybS69LwDc6458gM0yTc5
X-Gm-Message-State: AOJu0Yyu7EJRrwRWp21Ss/vnsnnLxhNWOdJBWZnDWNc/A10g7xPeKfhb
	CnjUrTs/I+GMOyUWdp9Zb/CojgEcGspdki8SZm9vvSaUCDGeM9Jp5WG+VgMdZP2OBsVgbgjf7+u
	D
X-Google-Smtp-Source: AGHT+IGn7xbws6guaION1bSRFmOWN0JaMk7skF758o9ovH7+zEPluYAuGUSt4nRnITwXfInNq7/QmA==
X-Received: by 2002:a05:6a20:2583:b0:1b0:2af5:f182 with SMTP id adf61e73a8af0-1b212d493b0mr19615966637.30.1717006324907;
        Wed, 29 May 2024 11:12:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbe9f6csm8300599b3a.127.2024.05.29.11.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 11:12:04 -0700 (PDT)
Date: Wed, 29 May 2024 11:12:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@kernel.org>
Cc: Gedalya Nie <gedalya@gedalya.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v3] iproute2: color: default to dark background
Message-ID: <20240529111203.3baa689f@hermes.local>
In-Reply-To: <f8dc2692-6a17-431c-95de-ed32c0b82d59@kernel.org>
References: <E1s9tE4-00000006L4I-46tH@ws2.gedalya.net>
	<f8dc2692-6a17-431c-95de-ed32c0b82d59@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 10:23:37 -0600
David Ahern <dsahern@kernel.org> wrote:

> On 5/22/24 12:43 PM, Gedalya Nie wrote:
> > Since the COLORFGBG environment variable isn't always there, and
> > anyway it seems that terminals and consoles more commonly default
> > to dark backgrounds, make that assumption here.  
> 
> Huge assumption. For example, I have one setup that defaults to dark
> mode and another that defaults to light mode.

Ditto.

Often use dark mode for VM's etc.

