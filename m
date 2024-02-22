Return-Path: <netdev+bounces-74046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410CE85FBDD
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9B9B21331
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C096D148FE4;
	Thu, 22 Feb 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMzTXYuu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E581487C5
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614447; cv=none; b=UfA1siVoI11ZyW4/4Ustm09E1qtA5tkHwerUekMiAOStlLrJJBb9gyxmyfoSFAcdHwJYiCEoR6Cb6MTzkEJPUfSKIdqM9gcbC18CfSu2L3SLKQMIjrUHpBcNOXtP8bmNLAxuO9ZOPqRwx8/hBj0voWpeFKQnyBjhKDvpBMGmHOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614447; c=relaxed/simple;
	bh=GX3YMbY6K8wdB+Bh7fud9b2vbdhY15SlVa5O4IqkTuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Asu0YCGJ+RABnxDh43KZU8z5amuAnNYastjtxLGa6euSH8mjBP9JAN5Cgg+1GJGtihpRWJFZ8Oyh8/BtkTr5nZgCUc3xa7tNZfJtBWSZRKGwrZsuKi3XADR3jtM/eHGoqNjsROXrnO0PBuOELsn4t42YnN4DKxEZhpEfnIJ4iN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMzTXYuu; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-595b3644acbso406048eaf.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 07:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708614445; x=1709219245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GX3YMbY6K8wdB+Bh7fud9b2vbdhY15SlVa5O4IqkTuI=;
        b=BMzTXYuugcMMRivtGdxGagJLKBMHQBdrhZUXoKFSVuoF/qk3XnD7nv7xoypHYTyLo6
         5FqGTlJrPi7RqqWv+Fxqu/AppC94Q9XeQNoiJTjpbumXQ3ZkneERrg1GtMwGzyqHoHJ8
         euzmBCkCOwLbnDog5y4D/SKIvYZ3ltYkzeZAXRnqiysFkN1/dYq2HecsQ1c143M1So2r
         CfUZUIGDzGqgxTIcsBeMEPeVksMiTBpg+LLMYDQBGtNogRtD+XWMw19jmlOKYgYiJIBJ
         Syc9Ss0f3FShBVD0BYXGnpxm6lp48nYuHR5mxIDSSUQVGZabXSW6XMzaxRxK/1AjdZY1
         /qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614445; x=1709219245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GX3YMbY6K8wdB+Bh7fud9b2vbdhY15SlVa5O4IqkTuI=;
        b=dZZ1e9o9NuSgySbZEgjWFuLRXWqvJl6/NYsS+l2cvXZLDPEoFxZ6GM7ZlKhk2w34hf
         hVI0Y8FHsq250XQDAFFatRbfG8LPBvcSHnurUDYwgyU7b5x5eAWmnQKH6wG2TflTADXi
         eTe7EhNnQT9g32/E3A29LNdIGKwMfAkph+DX3DstBDLe++ndg6eNjeXpzVXmKEHfDYk5
         yBtNq3agrqORIhbFOoCtchK/AQfA/M4I96DcuBovGi1d9xcBEOF2hFbUqc9emd65lX8p
         uD7TElbRmYdop9gHD1fRS0FfGZFmakdc//UK4mvdWBqWRSlHtFr3BuVuhpxFhQz2XSe6
         f3Ng==
X-Gm-Message-State: AOJu0Yynbd//g+k9ACGtsNixVp9GHqDcSpzi6FICr9pXk/POqFUvwCVs
	gS25zY6D8T0TnQtLhVixNP9ZuXHv68VsM7Do0sLsc19q6x7XY3az3k8q8kY8tzv1G0DFmUv3J1R
	NUWKAGdFknVHfXXtan5BxZ5RRzl8=
X-Google-Smtp-Source: AGHT+IGavzl+JPYL08h72cKLwoKLIzagiJ9ZKGrhjgQcwJn7BLlIjC4zv4k/Agbx9n+QU3DqE45s6eJLAwaxyRwp110=
X-Received: by 2002:a05:6870:65a7:b0:21e:e069:584e with SMTP id
 fp39-20020a05687065a700b0021ee069584emr1224606oab.1.1708614445364; Thu, 22
 Feb 2024 07:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222134351.224704-1-jiri@resnulli.us> <20240222134351.224704-2-jiri@resnulli.us>
In-Reply-To: <20240222134351.224704-2-jiri@resnulli.us>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 22 Feb 2024 15:07:14 +0000
Message-ID: <CAD4GDZw26k6cQnAvvgp=9Qym=a8ZdtW1M8af1Rg_d8UyLuQnqQ@mail.gmail.com>
Subject: Re: [patch net-next v3 1/3] tools: ynl: allow user to specify flag
 attr with bool values
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com, 
	swarupkotikalapudi@gmail.com, sdf@google.com, lorenzo@kernel.org, 
	alessandromarcolini99@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 13:43, Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> The flag attr presence in Netlink message indicates value "true",
> if it is missing in the message it means "false".
>
> Allow user to specify attrname with value "true"/"false"
> in json for flag attrs, treat "false" value properly.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

