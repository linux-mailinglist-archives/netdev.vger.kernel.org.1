Return-Path: <netdev+bounces-73247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A36685B975
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30298285275
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80EE629FD;
	Tue, 20 Feb 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTOZMUoF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE553E15
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426041; cv=none; b=nrrc6zKGnzcMwgR+20TagmFv2oHJmgnFmjTOKGDjtSprA4zTOlZY5K2EUkQG0fNKQZ4VpFmswYzW2ML1MMQM6pTl8y+FjSOn0vSiYXCma7l1ztl7AC4OV4hsS9JeQooHnK2Ujp0rMEGjUpT/7W2eC9iroCicsUeRvLcUNKI4lro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426041; c=relaxed/simple;
	bh=s/PV7qpElskRhq3eT3h1D21HJQdHFMmJsk5re13pDkk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=GQu49KQ96ERYv+HebTsm2TRKQDjJ6Y2cOPksRpRlaHyBu7+Mu7ouLjfpN3zrurzES1xJ2rsvK35eJ92SmYcUszFE+TyfedsGsUMpFFUABut/CiD6r+Z4x+hmtfSZK/aPV4NKbaM2kh/wk9zzhGkqAP/mmN4SNHkyycCUsuKGLKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTOZMUoF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso29344975e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 02:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708426038; x=1709030838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EkMGp94bzxo7V76A298vKS1z4S2mO5MpTKzBFFfqeQ=;
        b=nTOZMUoFAS9BLj6qwYJh3GFHE9c6oUhxvy0kWGimwYcdrZISvzrcYkOnCEJSR6h5vj
         bUQ0nLfE8YYHK/fFZoq9Bd29ZOb0hQx4Cmjdzo45in9vr+zhR6acdnN/uoDwSOsLIQqZ
         MTY6priqjTlHZnAZggphLqH9UEMRxJ4bQgqIkso6vDDmRmlwNVtTIwSLItKs6qR2G3W8
         95iKm69OT21EmSf136GMozK/7S+2kb1sEwO1WHs+QVfxfR4MVliBans+ak0aggnD0hfm
         sybNNcYeyOb4IFu8IRdUlFkDggJIBAH7xXQ9sL8lWtmUmgqdvicxpdfCu+zpiRMHg888
         sKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708426038; x=1709030838;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6EkMGp94bzxo7V76A298vKS1z4S2mO5MpTKzBFFfqeQ=;
        b=FYNYG8GujRJjwFybPBR6kn3lLiwyns+sihcOQWXRu3sDWXr6optGkIXfcYZvwI7WZL
         fawiK9aMcu+TtpI4wJO5miZJeZjh6ojeSVZWhZRttY1k8nB2mJUwz2Qwi/Su7wNTdju7
         O8eNt0pkn6SzAD4SLCCZ0eWka3k2jgsvKn33RNJxUAjYxymGc6SCJg2GP9NjA1Y6+rhH
         Hq2zVs823KvJRZuf6WvFicKMRUwCOEWRGJ4HzMWzNlERDYQIk6lHb37FR93hvSrB+mrG
         kheaYfndqZeBaM6+3KsOjPXazWJJpwgtSGPNXPoBI50RNPWSK55NmZzuvFQK8v6+mULQ
         PZ8Q==
X-Gm-Message-State: AOJu0YxJnKBU0gfxjYaTSHKFHmpkapVeLVzTeqBj0kCIP2iQkM1DjKU3
	c3wIDIF3Bai5AMbTP9LStOFvdvokiPrpTrUFH8EswPpy5ppVt99iXoyxK0OFq6tNijHQ
X-Google-Smtp-Source: AGHT+IGELMEIZfmxJxU+tvk1VFJ1QEXOWNpxlN4JhPl7TuoaOvPgVZscWoOhSm6uEHTGA6lJCYrj/A==
X-Received: by 2002:a05:600c:19d0:b0:412:5dbc:7530 with SMTP id u16-20020a05600c19d000b004125dbc7530mr6268282wmq.14.1708426038412;
        Tue, 20 Feb 2024 02:47:18 -0800 (PST)
Received: from [192.168.123.152] ([185.239.72.23])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c044a00b004122fbf9253sm13970788wmb.39.2024.02.20.02.47.17
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:47:18 -0800 (PST)
Message-ID: <143adef3-d157-42e9-ad9d-bc0b145d2e56@gmail.com>
Date: Tue, 20 Feb 2024 10:47:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John G <ijohnyyh@gmail.com>
Subject: Galaxy note 3 9005 webview fails after version 7.31
To: netdev@vger.kernel.org
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Manty, I am sorry if this is not the correct email address but it's 
the only one I have found.


I am using Crdroid on my Galaxy note 3, I believe you are the 
maintainer  however after any version update starting from 7.31 webview 
fails. Is there a fix for this or a work around?

I believe you are called Santiago García Mantiñán Nickname manty.


Best wishes John.



