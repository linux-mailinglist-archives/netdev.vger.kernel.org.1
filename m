Return-Path: <netdev+bounces-124802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D696AF9B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 05:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A341C213AD
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 03:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2145914C;
	Wed,  4 Sep 2024 03:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/wIqEYj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60FE4D8A7;
	Wed,  4 Sep 2024 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725422357; cv=none; b=M5UmamdF03lTbHFVEcoDdrhFQMXNwvt02Jds0Qla4XzbdRTX6oUaQqU1l1RLnV8ParFYp+D5NS/CKZsQblx1VqhlN9L7gVtMPpJGUd7kX2nqft4ZJIlYMnHIcdzoHOZZLmbn5iyFFSHPoHXK6FdnaGldcugewm1w2uMvZIsjfqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725422357; c=relaxed/simple;
	bh=qEmN3XA5U0AGx6zNdAnandIbov0vtnSHp1hBM+zM1DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzlysnTcNxnUqraB57itzp5819jiDMPdfcNm9dvKY2l76y3BeBvNrwdww/Sk7m/J+9aivsh7rGypkT/usru2ucGce9MNJFkPjrN019jzf/AI/hZsedjAIWjwch6xT5Z1csHt/yaIiFnj5t3aL3JBb4894vpdiB59Aelm0BnroIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/wIqEYj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso4233623a91.2;
        Tue, 03 Sep 2024 20:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725422355; x=1726027155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=acrRrqLBvKcmIog13eQf8nAeUw9CPSDpthg968nAWvo=;
        b=a/wIqEYj3GMfpeCvTqCuHMflTfFw3HOKNiV72WtFw2b5ZtewnutNr6kBPfuQw9kGIR
         2IL5P0/9Gi5EtiWHUErKVpFud8tqxBRqv8qkSlG21jyjGxLpJxnlt+Nw2EtCLif20qWx
         0yiI8CMY+8waT7SLUFhCqnNpgb6ec483kZ/pYhlPjevFlsMplnUQJuzvxEwU+c6Z+LlW
         hyKgTpogYu+9mZDJRwxpo8+ewkKsXYpnVvkfAQxW6QvJKXEK/EC7tLig861FAQvq9bF+
         skoogyOdqO020IbEfwC7gc5yu3GhssE19UdrU+4MtmJsv2HeYW8/OjaeAbOsOfDSPwCq
         5+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725422355; x=1726027155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acrRrqLBvKcmIog13eQf8nAeUw9CPSDpthg968nAWvo=;
        b=LCaBq04/x78rGdRXZ6a0vSCfvFO40DO9FPnWY/zUDwzMDRg1Ccjyq0qVflJ7m6wz/0
         Pkh2HIsVR7lRwdQRLt3lmoRsUU3lAcYTIENBeKFKWOwZprwwYZSd0os8aff9E1Ume+Xm
         lF+u7eL9mx4cSJV/9LfGcmu/mqM69r8qslRYhDb4SIYjnlAsieBqv12qIWj34uJnsq8P
         xGt7sT/4YssO/9TT+PFinL/E/nAOXRd5DQzRI5gGfahp9pUY27dn/PwulwiUSHnuP5zC
         UR9S5PKuX0fY6KTTo3MOqpvPy5eRX1um4K3OJppRp/SGmrPq0zYjoEBmxSVlNkWaDmm+
         DU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX36qOkoCxIaXebeXj6y6czSO5fW+Urei/Fl8n2soH45I/V74x5FX05D9uEXbGOGTdAbcdm+HXn6/YLpHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFpcPtamUr6qc3COVUEZsACISlZmo7VAAZLUHUVCrnh5aPZvnG
	fDqPCaHf5iuGJ3T23qQn6CduYx3yYnkgjnBLPmQ06NGInKoXZ/7E
X-Google-Smtp-Source: AGHT+IHnavHm7HSzWJe6xq7w5AUUqu6nDFzwEf+I+GOhMI2QUnHbgO6cDr/ua8FEDdAeNflJUpj+cQ==
X-Received: by 2002:a17:90b:3c0f:b0:2d8:8fe9:b015 with SMTP id 98e67ed59e1d1-2d88fe9b3b3mr14070299a91.39.1725422354939;
        Tue, 03 Sep 2024 20:59:14 -0700 (PDT)
Received: from hoboy.vegasvil.org (108-78-253-96.lightspeed.sntcca.sbcglobal.net. [108.78.253.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b0fdbd8sm12305167a91.5.2024.09.03.20.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 20:59:14 -0700 (PDT)
Date: Tue, 3 Sep 2024 20:59:12 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ptp: ptp_idt82p33: Convert comma to semicolon
Message-ID: <ZtfbEJH2yxsY2q1m@hoboy.vegasvil.org>
References: <20240904015003.1065872-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904015003.1065872-1-nichen@iscas.ac.cn>

On Wed, Sep 04, 2024 at 09:50:03AM +0800, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Acked-by: Richard Cochran <richardcochran@gmail.com>

