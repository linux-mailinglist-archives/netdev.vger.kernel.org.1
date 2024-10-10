Return-Path: <netdev+bounces-134427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F35A99955B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 00:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C771F245E7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DDC1E47CE;
	Thu, 10 Oct 2024 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnM8BpGu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3E1A2645
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600128; cv=none; b=No02jpyZ/C1OwBJj4dz+riBMuU4pFpRdm5fhfMdIhiNgHRgTIflruWIrl9dpIqoxWqvhx2Ol+FthBJ+MrCBc+I6G0p9nSfKvSIGiNOueZKQUGYiqcDvNlfsz1e6OD8n/LLVb8+ttzJwRLMjWql07heLrpGJ0bDcvgjkeB4yUHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600128; c=relaxed/simple;
	bh=3pJvSV5yjEwFaDzSqU8PVBcP3mzNNs34hT8K/cX8XUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssKK9W/A812BXtq8b+JDSKPSUw85pzYHhWKD/gj/jN2jm+yEPA5VWIsIRtVF6egQ8PZx1WtKS/4AXCU+0HBSGXaTajrX8sFdbeTayk7lmby+kxOlxUFthwv5n1r9cSuEAZQGn4PD8FI3/tobKdr0zeGRslX0QIYaAUq6sZ+q3vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnM8BpGu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e9f955cb97so824809a12.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728600126; x=1729204926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qe0mD1HSoaRIiqvVjoxbkGRLbKNZjFivoQa9F+sJ4pE=;
        b=AnM8BpGuAIW5wBBDO05vlyONP4yuWjWRLJqkEhXJ3f4GKfHAR5Vv4W2F4QdzqIHWKx
         +P79Wykt1wGrczwy/UgPyvO9WlhAAllDhh0SGUekC/kDZdOcsMSFR5QIm1EJJiTOq8QB
         FaS0w/nILA6IZw62ojoHTQJs1CZLtrCZllkkLWrDvR6ASe8VyVe9v2zrZkb6/RYf5wk2
         TQdCNt+YUhxHJmK6aM1jORHWOYeT3qm/7/GZwEquB1nyNrYePFWy8ajq62aaHbtrtdb1
         3hgW0bZoBLjOptmLV71KZtJxP0e3RrtQQNFdADeR1neadQxEZBj/U1OLY/sNJK5Hzem3
         8Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728600126; x=1729204926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe0mD1HSoaRIiqvVjoxbkGRLbKNZjFivoQa9F+sJ4pE=;
        b=Du72m8ZQBB6/Rx/RQEfbQVhRv5yaJeiqiq9o0EzS6m9uSOdN7Jx2QjzJ0O+V2liO/5
         9OakmMeREDiCiV9lwC7uv3+oGOTNwhoxRkMI7fnEaqlXaK3hi0JxWinfVlafLVJipLbT
         54zzaGMal/aRA25yhmibpWBlJHtwE+DgMj/ESB25IO/E0Q807gaKKdyw6MRiKLZGrGwG
         mapIufLYRp9+4z8bQp4V0ewzvEl1KIbtnzk6rLWjfDYz6UYUOHvXiRy/Q+OeXNx1/HWZ
         P1vnqCU0M9VHTl63VcYLXyUBN1pyVS/AtrXCb+rYHQ9gzZ4bgtki92rksbVEVmDFeCHb
         q2ow==
X-Forwarded-Encrypted: i=1; AJvYcCWn37XA7WkM4LbVLO1WtmFPh0p+yp6vaSyV0iuX4juQB/itEu/00s7c0Fg3TJZse1gRwFfVXwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9TyzLtirdm0W3GKFaPJUIUznUFGkioVY61iHFOTOsHoHpnhXv
	5dUj00L+RAJrsYS0hCxQguIh5rdMSwbgWSmT3Yx2mk8KwM0F1poo+zD3
X-Google-Smtp-Source: AGHT+IFxOX2r2eneZedZwPrZFaUOAYCFbYA7j3Kg/f+Icsaf8EYQN7+3oUI1Hpt1kLNMRiuUd9GkqQ==
X-Received: by 2002:a17:90a:ea8a:b0:2e2:991c:d795 with SMTP id 98e67ed59e1d1-2e2f0d8ceaemr829329a91.40.1728600126000;
        Thu, 10 Oct 2024 15:42:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fc5e35sm1898291a91.54.2024.10.10.15.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 15:42:05 -0700 (PDT)
Date: Thu, 10 Oct 2024 15:42:04 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, sdf@fomichev.me
Subject: Re: [PATCH net-next] selftests: net: rebuild YNL if dependencies
 changed
Message-ID: <ZwhYPAyodIebgF9Q@mini-arch>
References: <20241010220826.2215358-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010220826.2215358-1-kuba@kernel.org>

On 10/10, Jakub Kicinski wrote:
> Try to rebuild YNL if either user added a new family or the specs
> of the families have changed. Stanislav's ncdevmem cause a false
> positive build failure in NIPA because libynl.a isn't rebuilt
> after ethtool is added to YNL_GENS.
> 
> Note that sha1sum is already used in other parts of the build system.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

