Return-Path: <netdev+bounces-176742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315B9A6BD2F
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 15:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95234175CB7
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCE31D7E57;
	Fri, 21 Mar 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r9EQsmQH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA11D54E3
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567774; cv=none; b=ih+1aVMpNfWNT/ujZTnJZ6MlvtUlwv+K3FFqVsv8WO09HcrsVRnfJHabyk8AFxbW5et6v1ugNSl6727F/tDNnnRxlLHiA9qN0KwphxMBgmOf+MwUyHyAyqO3QLO/U9oDeUcmqubAbN0MgNGwAxpl4ILTCN9PZSbaeeFzq3LFzNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567774; c=relaxed/simple;
	bh=wz1AnSzb3OObfa6zVQ7Wa4AyldHuu2MZ4zGXWmqiKkE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qzGmbOwTsH9jNwzLdV+KVOJq+m9OEz22HJ++K9BlnwyueQKvFk+LeTpy8FDAV8XOTBdbF3ZDxZxk+9gaXZNN0GsDlfOwzODn0fT0f7Raz72kPl3K+YmJrWeZAOnkJZ5izKJcM0BBs7E52gG2QQWz4ypY09XKc+KXsfT8v2AB3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r9EQsmQH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913fdd0120so1236176f8f.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567771; x=1743172571; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpHITJUyFvYZ50WLMtQ/yT0/1l8sX+aeMoD7GQBbhi8=;
        b=r9EQsmQH1UucweYHGwZwrrJUq9IBzAKIKQn7/RN0xgY/63aAja9z9CmqxPMizqMRM2
         N5KMf2CEhpLT/gFbLQh1mxN+El6RG3NWEv0CrTJk/Chd4QZPNtTf4WcItKR4IOx4d/1w
         VmONWJIFjS0AG0m0B8rfxc3y6ehXJZ4HrLi0anMD8Ofq9XPgJQadI0Q7ChM0k7CRwBfu
         37kOj4EFQPBJXm0+OEAYkB0izZ5aQKRjqnDLZQhtLi1Q4Upqp5dqCTP2qn6urIfArtRV
         9syJA7hgevG/VDgZR1FL3RhSKZSX7m9eSHGa8RnK9YtIh6R+vKKVDecZUNnr3rD6ESnk
         Slpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567771; x=1743172571;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpHITJUyFvYZ50WLMtQ/yT0/1l8sX+aeMoD7GQBbhi8=;
        b=Gzhs3AOCgxYonxaJDYcZ17kI2z4bX8a9+fF4ak17gc5ubGTYxYjPTdf/pYQVL7BKRG
         1zRhLR0859xG4Q/SH47+Xlf9pVBa6h2HwV6ffUgRnwfl8t6qFt3VeAfFWFg2UtMRTGqh
         DJIViSf7MitUpbSivCVm6wcw2YefCGpwNk6WunCu3TOSKJLIRnHWUTzkSsxb418y84zQ
         p+XO5HS1g57ctSJwzMFMdTLrm67b429BJB35YXObe8tpPZp6khzFohQ/nwsTGLjHN6tl
         eqwU9OiZpbQNupSdwoL2377nhD6kjkae8AvcsxYeRcZBKSwsG2tI4yv/umH1YMzp1X3g
         r0hA==
X-Gm-Message-State: AOJu0YzYUtDqIqVkz9q3PZLVutiETRIy6HizykVJZu9rJFLQldnw3Dy3
	IOrbe/4DubtqbzEzrm9sRymNtJIp2ygvd3YISs1sTm8cfikf6A8+D2q89CoerFw=
X-Gm-Gg: ASbGncsvur+chILG8r7xmGIBNn9s9jNAySJTLEBTReMqmL+1rqnOW20kfDawXwt69o7
	pvNj62sTLjnguCsbKc0UxfGlnGdd5Iuc9NNZjIZ0/qCePxlT++p6G96jAFLUKx9XyTY1IEll8bX
	8OVyLa0gTg/OIGPgZCuA+2A2g4YZ9Ooa3gMYZhoDoHNhZLq+ZiZYPtY8auCsYMiu4DsF1QCy1FP
	On4m4pSyabWAY9r1F4eMREViX/bxIYbZsnF5S295O8+WjKctEISG3R2jI+zk6vuz7e+tRdjQozD
	3w3Frk6F/phr/0ZJiv3e6XP6jIx9x+vjvQSz9QYNAnuABrktDBeVZ8QzvnPE
X-Google-Smtp-Source: AGHT+IEH1mOTrAxEaorsQMoun0U/5882E8AsyjKy2ty3cPPZ6o1pgW0IljQtmqUdMXVnJJ7Dop0J1Q==
X-Received: by 2002:a5d:6c61:0:b0:38f:3c8a:4c0a with SMTP id ffacd0b85a97d-3997f8f5d31mr2957557f8f.7.1742567771356;
        Fri, 21 Mar 2025 07:36:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9e6445sm2526221f8f.71.2025.03.21.07.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:36:11 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:36:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: netdev@vger.kernel.org
Subject: [bug report] net: nfc: Fix use-after-free caused by
 nfc_llcp_find_local
Message-ID: <896cec0e-53b5-42ce-a273-6954570466e2@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Lin Ma,

Commit 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by
nfc_llcp_find_local") from Jun 25, 2023 (linux-next), leads to the
following Smatch static checker warning:

	net/nfc/llcp_core.c:650 nfc_llcp_general_bytes()
	warn: 'local' was already freed. (line 648)

net/nfc/llcp_core.c
    634 u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len)
    635 {
    636         struct nfc_llcp_local *local;
    637 
    638         local = nfc_llcp_find_local(dev);

This takes a reference to local.

    639         if (local == NULL) {
    640                 *general_bytes_len = 0;
    641                 return NULL;
    642         }
    643 
    644         nfc_llcp_build_gb(local);
    645 
    646         *general_bytes_len = local->gb_len;
    647 
    648         nfc_llcp_local_put(local);

Here we drop the reference.  Meaning that another thread could easily
drop their reference and then we're in a use after free.

    649 
--> 650         return local->gb;

The ->gb array is a buffer in the middle of the local array.  We
should hold onto the reference and only drop it in the caller when
the caller is finished with ->gb.

    651 }

regards,
dan carpenter

