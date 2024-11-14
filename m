Return-Path: <netdev+bounces-145047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA989C9339
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF20282E92
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75B11AB52D;
	Thu, 14 Nov 2024 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AarQllUL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12A18C930
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616069; cv=none; b=A2L2Nhkax2eVyaeWp6EZXwvJgSxJ5PqU4ARfRVjaIUMliCnFT5UJzMlVUlK448hKWHAj1nJI9F42iVqGLLXt2gn6drl0U1cxfPBZDJwaPKEag/e6t7OEDcJ3u0GRJI2XoxtCb1v/GtTmq8Es+dUOrvs9c+9dG6A0anb20n3xVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616069; c=relaxed/simple;
	bh=VlqmW0I3vU8PGOWRV6/uXVqgaWAB02KmO7Cip49Y9Ck=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JUu5dE1W75oYnvl0S9KXCD2zN2ZjlViB91XlzVhAf3ihkmM8zsb+xfmcrkAb9z4pQiiAr9Y2T5dhu9avxlN1L3Zj3iQdX71QYQlPjPpZaJsCYIo16wZQAT26qGqqRkAbMNBUqvu6fjdbFtq1DrVyT5wRQtrwM1ZV93nuK7Qah6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AarQllUL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460e6d331d6so6374961cf.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731616067; x=1732220867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffAf8BWyy6teKWVM9dUteu+T70MIj5hSmKzS0CriiMk=;
        b=AarQllUL1avzlEEIygBo05MbfgEcapqN8F/eBZQpqPqSQVCzTtzuVvVeO9xWCAo6yS
         FnkQ8lAczjfmMhRk/zQYwuwbRr31vcfU3h1TIe7/9uK+XZPBGzg62ZcZLnG5oCI4sdJb
         o2J1N0TszuG2L6A8ycKxiNFMRCrkAtqCBaenmrNt/eCf3FcEN3uWPvARbq6tSs2fxkQy
         j8zU0IxvvTEQxSEBpaDVxX/eJJiFPaWKX5oDhkwFOlTVH/r+5s19H78TymoBt/3pBRyP
         zr0jAxsiL0QHKXObuAMSuIt7wc5kdmeH7Mg9Sc/PXan5OR62OF++Pt5K4xMpMCiRRsH5
         Qk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731616067; x=1732220867;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffAf8BWyy6teKWVM9dUteu+T70MIj5hSmKzS0CriiMk=;
        b=n3dqSEIkIRYVfgEfd4Abchv7VEj9MC/gQ/hJL6GwbfeG/DbN1X//B42vYuYBNaQ2GL
         NTESbJ9KyBlDMTp30bdzsbcdZ35kCKVzkbA0EK6eFeXgKVaMYuzNA/KyEvbsWTtQA2br
         ++nRLAramITprFaYwUxchYvq2bd9YzpbXS5E7arsfDgct8cS7jBNL9FbeuYFLXg4mJ3o
         FZa+VI1R5wz5PUfxS3sEJTjNmmfvLRGwPi+tNZkgzc90hJb7yetxe2wqr/rxEVH1PXcO
         0qXSIQGOZd1TV8SqqsMiB0AkSz7oHxmdlnQjRB0bKPQxSK985qTbjwvzakZr08OE1Aez
         qWRw==
X-Gm-Message-State: AOJu0Yz+7nYijNOjnQB5unX19oEVN5SyW1BB/LVMBIXqEjr8Bb53VajP
	0EgnI/JwSFxKLXuvK/EIg8OpZn81bdbSqdxjJHDnGNo6qUNGPuSW
X-Google-Smtp-Source: AGHT+IFqZE/LnHqrNZinz2jQmvyb/JI55JIpwo2MEGQh4cy16bGIvmVjvJukmrAwA3sV2HhcUwfJVQ==
X-Received: by 2002:a05:622a:540f:b0:458:4129:1135 with SMTP id d75a77b69052e-46363debbfemr2119271cf.9.1731616067023;
        Thu, 14 Nov 2024 12:27:47 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635aa0be2esm10143451cf.33.2024.11.14.12.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:27:46 -0800 (PST)
Date: Thu, 14 Nov 2024 15:27:46 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <67365d421d74_3379ce2940@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241113154616.2493297-7-milena.olech@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-7-milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 06/10] idpf: add PTP clock configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Milena Olech wrote:
> PTP clock configuration operations - set time, adjust time and adjust
> frequency are required to control the clock and mantain synchronization

s/mantain/maintain

> process.
> 
> Extend get PTP capabilities function to request for the clock adjustments
> and add functions to enable these actions using dedicated virtchnl
> messages.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

