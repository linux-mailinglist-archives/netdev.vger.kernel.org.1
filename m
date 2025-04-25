Return-Path: <netdev+bounces-186700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC38AA0730
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB441614A2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1DF2BD5B1;
	Tue, 29 Apr 2025 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4bzPTCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA282BEC5A
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918846; cv=none; b=QM8pg9RRbN0rcDjHC7ladLaazq0SJH27xS7rTFXgiJawwozKRMeiy5F26DYMB4fnFtezjIjsu6BWWpK6cpK9UWUr7+9b4JW83WFF8YoD5nnvxyr8GWNtQGv9MeHqr8X2YUoex2l6cb4mE4DUjXPVzhr/LnLB3IhNOeu2C2PT5vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918846; c=relaxed/simple;
	bh=BSC3dla42moPMrU0yQ/pvZePbZxECOmtkmHuMac9qpo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=msSRj0y/q1q2kylYYAcxqjy2uHcOuGV6/fNi7Mwe14LLemWCZQkXdDu5kW3Y/Z5VLR25eLStl8wMcymJJ1NDTOm/PEq1GK6mWg3F5NEYiV20DbyArtiJuFanVcTmvjUlS3KHksqXRg2qWOsTYN3JZ5XiEx7kdzJxQe9kJb6DseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4bzPTCH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so5220133f8f.0
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918843; x=1746523643; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6DnaOp9YnoSvloLFGHDcAveq1cMpKlKiOJw4/PMe4kA=;
        b=T4bzPTCH19xaah4C1m4DopyMT3Pbn8Wuha2jsrpD7e57bfg1bWveEXpfCKQ78f2zxH
         lDUEBMlGlxImIStXErcOydtw4W9muNcu9YdQ85DSHwB27QBNwToEe+AJMFl/xf6crk9q
         RcZviYHZqYVR0Yjmfi6kyrPDYiOk6uFlQbm5iHKkJ4r0QKXEoy3FZBIPtS2pPpmJ8r2S
         G1Nlrd23q5SIItJ9flI8CKmc3kKbO+V2ZnN1fqL21hMdJ2WUbgNFwNBUOPIx+vYU3vvD
         6apxrTY6tZtLEWCvDc8CfKDKVt9LcL5tNKGnFSbc4qVCIN/C6A5kAMmrMnN4KJcGg7AQ
         IJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918843; x=1746523643;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DnaOp9YnoSvloLFGHDcAveq1cMpKlKiOJw4/PMe4kA=;
        b=FZiWyE5vXxpJcPpHIwIdmjuQTPXtjEs1jLQcGRQBSnsZImGGmn8PdhZnYQlHsh5tpc
         fh833tyR6TZyU4CLUyz8Md8+DqyKU1xRDaEYvhXr0ZvkuKVF0bD+K1+APqlaIFcdQEXS
         apITfDDPNBUWHC6vTBy2uYGs+EguO0qnWTioY5T2AYpcBTJYUNQCOyi9Y6MJ86vCjR+W
         TZSPnti7HhlSZDG33ORHLySq5CmO6h102DuUUL+JwX8AVIxBOUt10r+pezDgFsJW2rVU
         Yw0tUoIzh41TOvPTQO0dUInXbf4eeICKh7HIldrfrl7Pezm6t1La3UxJu2ELTqJTJI8h
         +pZA==
X-Forwarded-Encrypted: i=1; AJvYcCUxseHRIDdQI3W1rMHfXZVp3RtAq8Sg1QsKE1nr4/61826F74NCZgMkiNrHkzfuk+uJIPR3JGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjHMLXB4QVAbeKjWde4Y/rhq9ioEkvIYxb+soSCYXYy57udqja
	uO7xTApDFfcf6d3phtLfrREsPqwQH+1LMQSYuIcSHWp3fs1Bzug/
X-Gm-Gg: ASbGnctWMmjSjx64s2GKvToe3Iu02KaspJHOmkGSgXM4dieQ8xnNRFV5alO99u4OVuv
	vtk4T1AWoybdzvVYwQthnR5qMouZEI6g3bz72qYGj2/m9z1eZdN9zWcCF94yD+Cu6EKknqSJWVb
	MNlbd7415R9S8MM6dOgI+6/sZbCQBNOIIjxB/1+AdED7hc4nOwgpiqrbPpS8utQoTx5vaqdcEV1
	ULP20VCL2ih13k577JfIIA7Wk9qcAcO8C6BPsKtn4f7Y7g40pawtp4F2XGxymfy9g29+CUicBuE
	9NIFLzmZX/2b56f6/W7uny+6PvnKpYL3XNvVQQ7v0lkVIg0rr9J1Zw==
X-Google-Smtp-Source: AGHT+IF4EWDfXYgNOoE1TmAFitok3j0Wghmy/IwgJ4OQV7NvwspILCJHQtxz3RY7Vg7H5mPyRbe9Ww==
X-Received: by 2002:adf:f4ce:0:b0:39e:dd1e:f325 with SMTP id ffacd0b85a97d-3a07aa6fe3bmr7229224f8f.31.1745918843133;
        Tue, 29 Apr 2025 02:27:23 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca4cbcsm13211348f8f.25.2025.04.29.02.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:22 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jdamato@fastly.com
Subject: Re: [PATCH net-next v2 04/12] tools: ynl: let classic netlink
 requests specify extra nlflags
In-Reply-To: <20250425024311.1589323-5-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 24 Apr 2025 19:43:03 -0700")
Date: Fri, 25 Apr 2025 10:15:26 +0100
Message-ID: <m2y0vor49d.fsf@gmail.com>
References: <20250425024311.1589323-1-kuba@kernel.org>
	<20250425024311.1589323-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Classic netlink makes extensive use of flags. Support specifying
> them the same way as attributes are specified (using a helper),
> for example:
>
>      rt_link_newlink_req_set_nlflags(req, NLM_F_CREATE | NLM_F_ECHO);
>
> Wrap the code up in a RenderInfo predicate. I think that some
> genetlink families may want this, too. It should be easy to
> add a spec property later.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

