Return-Path: <netdev+bounces-117874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC0294FA5E
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 01:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69EC1F21A07
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11018455E;
	Mon, 12 Aug 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juHEhJPb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDC15351C
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506101; cv=none; b=m8nFTDjAhu+1XqiqiuIyQeqVRX3egfzYtV0PhCkVZ/S95odq1jyH5C6CPayJHZKEhgNZNTyF4tmJyZxkw6yIK8MkoMzKy0GfRUMWy9rztWMsU6RuAhhu1Orlh35wDOXqC9EUi1CS3uJTx6T4y3yj3yl+nLk5UvD/H8Ned/tOTk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506101; c=relaxed/simple;
	bh=1aIgcqg1VeBqzYci2JHMEtbp/dyqsYF9JCUTTdRCb2M=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=pyBv2Gmip0sjMjKKuJhnsRMid9QrwArKw4djHepKDlmY9xLmsuiGFHC6Svoy0als7oZn2xHCbkIiI2LAsWvJB1nPxZynYOnMaf3mvcY+7YKA3CBhhKkxVuKDi25VKnrEkuK+ka5yg4d90qcnSsQfkzm0RrOCNcELLwsVTW6CRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juHEhJPb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc4fcbb131so37121545ad.3
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 16:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723506099; x=1724110899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:message-id:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1aIgcqg1VeBqzYci2JHMEtbp/dyqsYF9JCUTTdRCb2M=;
        b=juHEhJPb4X28U32L2ld4tQwX1vU9odlO/LnDo87Pm1Z19z12D5lMQAcI37d8z8QWEV
         xBslc2OyCpchlPMruJShIJlV/bQvb581DS5Dv7BCO8iZY80fjnxZBzPESCPjzA+YWVGU
         cjOonNes/2szHrtJ+OmH3Ubei4UPoIZLmTn/8APJ3p6StAqO/BAwXOyMtWBWrIY/xeGx
         xkxNceJl7ku0oYATbiGKZ3zbDt3vFvrh5dmGAPQObO+lL5JFnpBffokxcSKkMCHusCeK
         9ONErilkT5zZkwhTHXD6LdZ89mer6fqTFwxRDh4Ykg8vEXF+CVZr4Aaa/slCRFagSDDe
         swjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723506099; x=1724110899;
        h=content-transfer-encoding:mime-version:subject:message-id:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aIgcqg1VeBqzYci2JHMEtbp/dyqsYF9JCUTTdRCb2M=;
        b=BT3m87NZGYof/+4sYch7t2kBtX5iGAiML8W6VgNz7Ecb1UWtt2SPGbqTi/AFSHyuB6
         ZzGpE0KnfDlHmMFeSKWxnfamg1SKXenVe0Qou6Hc2vIrqHviz7L7SxyOaUAGl7Fy+q6k
         dmWfyf15DYeNSsrUSjYYX1TXmXoZ6aPWtsg0f5wwckypbPxZFNrug5ReFaHAXIQ9J2DT
         Ck2XOKmltphHEJPnyujO915iGHiuVe1ZILOLgvBojfG14jNT3DvEiyC1CG1DXXdty5E7
         RWE9F0nMj66gLPW240GTdOXUnTB8XgenSgsWQh2Yx7PWbisczDKjI0u73EeJw5p5NUbS
         3NeQ==
X-Gm-Message-State: AOJu0YxzrPWzwt6HRvLftX3vKseAE1GhXadWjOKchCINAIbjHaGfz/ou
	BRQhMyuT49rQGOCiA4tet0El9kpNX+edXgqbMr5bwF8Px+LnKeYcDj6eDYXZ
X-Google-Smtp-Source: AGHT+IFyrJ8WedS0YAu11EHG0b7yfyXgvhg5j5CUiTn/ipK5DpmDRgLtFJTwy36ePSFBN8rS2yENsw==
X-Received: by 2002:a17:902:da85:b0:1fa:abda:cf7b with SMTP id d9443c01a7336-201ca121bc9mr22138505ad.9.1723506099249;
        Mon, 12 Aug 2024 16:41:39 -0700 (PDT)
Received: from [127.0.0.1] ([59.153.251.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14e084sm2185605ad.110.2024.08.12.16.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 16:41:38 -0700 (PDT)
Date: Tue, 13 Aug 2024 06:41:32 +0700 (GMT+07:00)
From: a <tcm4095@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Message-ID: <2eb28c84-5475-4b4a-9abf-e78f79aac0a8@gmail.com>
Subject: Re: [PATCH iproute2] tc-cake: document 'ingress'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <2eb28c84-5475-4b4a-9abf-e78f79aac0a8@gmail.com>

On Sun, Aug 11, 2024 at 11:35=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>=20
> Hadn't looked at the man page for CAKE in detail before, but it appears
> to be trying to pre-format lots of stuff rather than using man format (nr=
off)
> like other man pages.
>=20
> For example: indenting the start of the paragraph in nroff source is odd
> and unnecessary.

I added a v2 that also reformats the man page to avoid pre-formatting.
Kindly check it here:
https://lore.kernel.org/netdev/20240812044234.3570-1-tcm4095@gmail.com/

