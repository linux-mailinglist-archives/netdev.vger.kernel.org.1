Return-Path: <netdev+bounces-143331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0489C2138
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8119B281BD3
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A1521B436;
	Fri,  8 Nov 2024 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1+fPKXu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52621B434;
	Fri,  8 Nov 2024 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081200; cv=none; b=Qv4ZpYxdqGZaYV+nN8lz/1n0st5rcu6Afr2fugzPJvsuzlsnr/QHI7CH2mUkszCyBTSHXQDOcFoC/yy+m9yw73D0zkm9F7bCnX2ySFAeU0PUD1ZP4F9jtqoaqv4jEIWi41sTTUsFMRrXcC/a2clNOOHOKJDMBxAF1H9fwdPzDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081200; c=relaxed/simple;
	bh=5uQG9OIysIhC/7dZTzhTQXQDoJZEzUz9YUwOxXN5uzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBdh75ovV0RHthn2gqFHsk/8317aWCH/sxzU6+QvM6Kz+S4wMA/zPx1SfY5sFdMG5VVBsVNGc5iQNpMhsgBL5NZmmbL9q7X7XXVLgBB83+DU1DoeRF4BrJDQNYq3CMY0fMBU6BfgrhbmlK00x5aQUYivEzS1v6L7vHYa29yVJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1+fPKXu; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so1891575a91.1;
        Fri, 08 Nov 2024 07:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731081197; x=1731685997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnHC85TnxQe2L8a1MRkfCi31K1tJxvxUT941pQ32lAA=;
        b=H1+fPKXuIGqZXNBO1Z9I4WmRu4/RJfgEyDSMmOeT6JvJ5au90STu3lyk8R+cP09SRO
         EBdkCjFkVgIOGS1hWO1kU+lfex5fTKm+VdtnbsIbPrSYDqPBZK+dWWstkWVj8INZxmZy
         f2wnUjZP8OUB1JveOiy4Az4k7PNpm66b2mREtfUvkJ7Vr+63o1vU68t6CMx4xd6tx92P
         dg//0uXLqRaU2FhWSP3hRs8NPsZtKTdXWBAXhcK2/TTfvvg4wHomBu1rgagz9xgKyz1d
         pheomr3UZx+kOkBhZbHkTOZz4b8CHZHTZ++WjxI+RZ08D/ygnKo9m86BmdfBYHX08BdB
         8GxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731081197; x=1731685997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnHC85TnxQe2L8a1MRkfCi31K1tJxvxUT941pQ32lAA=;
        b=Vq+c4TGFd6yBGvvIIBU//iO8X00uK5RV1ptm4dQqI3511XJF/h1i8BXy2HiKbgW1+j
         MedEq0wtxyALDzDeTuek+q67SladH+xbstT547qd2l/g/mrTJakzb+ByPE3quc+F3hIb
         nGlio601V0OJ3h6qU1o2AGFoByrxYYHN7s4WYOeskCgQY8CBdFck6OTT+FNFvSneWwV8
         tQhmXCZsjMyfjoP1csTtjTMmAU4ZO/qJRXCvS+60Cl8QmWmnuyaTTVu8FjxhQyqckzlB
         TRMIV7kiblo6nWFJAsS3K9d51C4Ho3kYkSta7DNFiplJ4MlECb1DolkL+sW86d0jMQs+
         FRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHAUBSxogZYkNr6vfnn7QQxKlhWsmUGEV4vp4kc+Nd/lxeHtO9UBGqTvjtWqKRSgNwIXhtgTR+0yL8gTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRqMAmm0sFWhepq9dwn+gKNKiXY1G4kNgI5nQiF2jWT4zqXafw
	RrmB9VPPO54RnijHc1JMFs2r8Gy7nWNiziPB4C+EoaILhJei9iA=
X-Google-Smtp-Source: AGHT+IHqBBPxDMeIDbJQnlIMKgwH2CtaaYDlFPcy9vMcKovezxAsJNKN5PMzIQY0FckksNtHecaGqQ==
X-Received: by 2002:a17:90b:1d01:b0:2e2:cd2f:b919 with SMTP id 98e67ed59e1d1-2e9b1741152mr4638592a91.28.1731081197133;
        Fri, 08 Nov 2024 07:53:17 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc8073sm32027255ad.5.2024.11.08.07.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:53:16 -0800 (PST)
Date: Fri, 8 Nov 2024 07:53:16 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v2 1/5] net: page_pool: rename
 page_pool_alloc_netmem to *_netmems
Message-ID: <Zy4z7CAs2KuGVgNl@mini-arch>
References: <20241107212309.3097362-1-almasrymina@google.com>
 <20241107212309.3097362-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107212309.3097362-2-almasrymina@google.com>

On 11/07, Mina Almasry wrote:
> page_pool_alloc_netmem (without an s) was the mirror of
> page_pool_alloc_pages (with an s), which was confusing.
> 
> Rename to page_pool_alloc_netmems so it's the mirror of
> page_pool_alloc_pages.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

