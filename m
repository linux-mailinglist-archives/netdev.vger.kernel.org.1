Return-Path: <netdev+bounces-178041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2601A741CC
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 01:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FCC188E109
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 00:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6F619D060;
	Fri, 28 Mar 2025 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ+SLJbO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A39E195FE8
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743122453; cv=none; b=YK7O636Z5sCFEEu80C7XGZHYdzDoTVsHNjVbw6oELXaDKm5DMV6jsyCe4gEOg9aPrjdM9rOly0AtYhq3ienFMP4eyLjCh6npCdxYtv7j4fR+y5NyhGh9Xq3NzHfiJ7oUX4Dz/nXyySW8W07sEFMgaABE4hT4ACJ8qGZfJhn/wLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743122453; c=relaxed/simple;
	bh=+zQHtYHbEml7ertn/dYGV8LY13TCVxMKeBDDnpyVaYQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ezcCbRjhsbgv7v/ag42pbMFmWswsIHsX/EZl7dkzScebdpGjdL+OCreglUc3AWV5wXR+l4Uu6gnr61HrKDo2VcZi+q/UjVR3f1qieHj3TGAJqbhOvcxJBk2gilNE9GOwwcDUDwqtLNNUN3zx4y+7eagEK9nqM3/+meaqL/AEmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ+SLJbO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8ffa00555so12970316d6.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 17:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743122451; x=1743727251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmy7ReAiz5B5OYgiQuAA/En13omCyQHnWx9KjzRqSQY=;
        b=iZ+SLJbOG6sXIhenSndoJRsZrhbOv1FY3jJ5zC4j0xKdyEfGQY/L9/8+HkZLBMLXKN
         rYFCOzpyNnQZiA1pNQ1vrOe4Rz/0lmWV1koz4zKvG8uZupdTTk3ot4PfI7+n1GHelBuw
         0RFNWpV2+o/JUUSUSXj2898agpTS9isFZy+4iCwym6MH3RFWLKMDKWgIumLJpNrrSDFB
         6ft3DlUW3rI07O4+klVoJU5ED3rusWWoivUCZ+NY1bBSyxp7LAFzjRAvzl4KtNjwibhv
         aMSGsMvzdDOVyLnRYrYaAeWanVFtBNu7K+hJcB6SKJ4Pw1p1YlSHfv9aLXnlgc4zPfCp
         94VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743122451; x=1743727251;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wmy7ReAiz5B5OYgiQuAA/En13omCyQHnWx9KjzRqSQY=;
        b=QhC8VJGLUVbaNIT2W3d4WCoJWnx/BxtqXFtqQglO13rvUK0qpkjTXdXNnN74Xylcve
         SYf5pYGRi46tN/01NgLoI2abKWUaqhCjG779j6JFp2NE6xNy2W9j9zIYQl/NUPWf7L5X
         D/sovO9PzCWdC1yd/9wxfTMmpq5rS2kl2SqztUHSB4XL8xWxlyUIxCFOzmH25+2yWYU3
         Pu47eVpqneDlpFYXSdBgWOhc4vCWDc1lyAL1CL8sy24qh82kd5vl0DyvYoksf2nvzqss
         dXcBaTzBfeRT8QzH/KfYgkSn0/PacYhH7vxcPnTrxGywUFodmjPaMMMNpjqnI9Rau9JV
         GEjg==
X-Gm-Message-State: AOJu0Yw2kRutrDbijNqnMjISnM7YNw1/zi3NT9kts4/MG2z6GENbSP/T
	Ws+42irdW4kvsVmf1ZiHRNHCkLrBn8kDVbmrywtYyhQqKg1atNEw
X-Gm-Gg: ASbGnctzdDy86EscLROK1/qRgT0KA2kvGWP91mWH3Gi9O9VwSCAUTxdIO/90wRkwKkp
	2IDHhGDDyh8UMYBd/gKIhGFHSOn4i+D+sFW7n2mC5LC1W4FulfGRmizMgFfJx26IZ8PSxWK6Xbo
	pItPCOqeeCNWVE25JeX0xvT4xYAr1qqIsVfmBNkZ3LknMbG918twq8Ej959Cw4wR1abQBiFFp6K
	A27LYGhGh7zzzSzAqQy2GwVGaYulIMu1fDbSLKsQBQMTNrDqWnvsqYwFYb/260fN4PxYqpjCqyK
	7rbVs8wox2tFUPLLcVl3ovGxFoQjtJ9bbpu7WCvHgX43nm2w/fZ28RFgzp4qPXQ6y6Dyw54PdDX
	Dxn0r8oPvyolk5v+hF5jVLw==
X-Google-Smtp-Source: AGHT+IFBMqvAGIoPn506G3Hp//zgEl0Kebdzeat84boJUhJ03qlKRh2GCJ2QESuaLei1fGzIf4yMRw==
X-Received: by 2002:ad4:5bc8:0:b0:6e8:fec9:87ff with SMTP id 6a1803df08f44-6ed238ad8e1mr103685996d6.23.1743122451081;
        Thu, 27 Mar 2025 17:40:51 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec97718f7sm4638916d6.69.2025.03.27.17.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 17:40:50 -0700 (PDT)
Date: Thu, 27 Mar 2025 20:40:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 sdf@fomichev.me, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67e5f01245b98_11b3cc294b0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250327222315.1098596-3-kuba@kernel.org>
References: <20250327222315.1098596-1-kuba@kernel.org>
 <20250327222315.1098596-3-kuba@kernel.org>
Subject: Re: [PATCH net v3 2/3] selftests: net: use the dummy bpf from net/lib
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Commit 29b036be1b0b ("selftests: drv-net: test XDP, HDS auto and
> the ioctl path") added an sample XDP_PASS prog in net/lib, so
> that we can reuse it in various sub-directories. Delete the old
> sample and use the one from the lib in existing tests.
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>


