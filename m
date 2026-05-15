Return-Path: <netdev+bounces-288290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIwTIBIYB2qQrgIAu9opvQ
	(envelope-from <netdev+bounces-288290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:56:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8369055002E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B78C31E71AE
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3AC481243;
	Fri, 15 May 2026 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B9L1bv3T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA29481235
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845894; cv=none; b=t59cpaldtDnfazbyeWS0pfPwP+QIbWNOnfTCjk86AHfNyzD1tR+O/xd038yv8m2kHn21vXbzMkGskNSKrYjGCUiAIMIFvIngnU5Gf+Swy8OGzuo7uXAsVFBE5b9ZvtY46n/6zaVf01FO6V+pumXhJtGXe0o0qjCTKWITYBFwgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845894; c=relaxed/simple;
	bh=IXAWDiwJZ1QASVlqz6X2kJrPjiU5LXr+EOy8jYQfQp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j60A0tn4uRf8v2NlbtxFByj2H3nE3PDP24yxsQq6x7PbrhioyIcY447ojVYyKztUl00dN7HjmBBPv4P5fdiH26mFE7CIA40dI6fRd10wrlTXjNigP7YM6SyyaU4kW4TKovof3a4EbLp/AOkaXvveCcIN63XNjylHNGaDZ0B5qzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B9L1bv3T; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-911449d9d03so173035585a.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778845890; x=1779450690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8Qj5JQsv1EWBd2kSvBn8cz0jUbxv6qKtDKlr9fP+AU=;
        b=B9L1bv3TzTgUaNS1HEAGSFven6YCsAEU+r65+VGgZSxztP8RzBuFgz/iS3H54F3IGX
         VpfL7SbIaRWaCrL3fXzjBNL2HB1CRT6gwH6wygsW5Q2uYP8gHUS2tdT2TqO4hF2pLQI6
         A0YEtVAPqIoaW08EZphorJmXUFrUwC38DawCjgCbd7S/1pO+Z8fuP9eaxpK7WdpqKXOm
         L5/zoZ2OHvrYee5r2d13lFQxHwkjr2FFLQgyYl4Lla7T3zTrw8EHb9efWFRcLt2xJQcc
         npvQOoXEA7Va5K91+jJ/6MB5sm3aDh2XDtbIiZg7TI5LIEqIc/nJL3hNBxHm5gbfdU6g
         8v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778845890; x=1779450690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8Qj5JQsv1EWBd2kSvBn8cz0jUbxv6qKtDKlr9fP+AU=;
        b=sJl94o3Q5hIlBVp5EhB857B193x3WwbTL92W8cmBCjOpvHZJ9BIF/FwaNKl83K8k4i
         6TD7IXQ4KKvBO9ACDGOtJm7JfrSvNm2q7encBYXFu+QbVf2zdPrgvt6pDKwgo6donWX9
         vBKGGBTqTtrWRTLVFxfxmmQx0T0XgrTbvnPLVjYBFReFrSihfIFDZ67LPqVrXWmz6sSg
         XF7D0Mj9aBe+4xNNlmbj6Wu1oAXyitxHGyrpJJvsbdc6NHoRDddFQPF47cwuUOikuJyB
         bKmX5qxuiH4HRWPZrNiIpI7r4tDimWhtjVyxtkg6OtmUDKDXK25gwVBnNrHBPp3i728r
         A5CA==
X-Forwarded-Encrypted: i=1; AFNElJ/0SdqEsZOXh8oDa77EOfuMDZJrlWBGouihFC1tEhPKrfntT6miDk3/FmOjCoUGmtgENb8EBVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzFJkGJvyaDeTdy9J5ZHQfgHSknefZKyO6n6DQDJHQkKJFRjN
	nWOI6IdrxaLbZX2Ce9/tRb3DL9ST3J+8yAq8DLVaBjKr6LT47L+1s97O6NitPge7DGE=
X-Gm-Gg: Acq92OFcWWowudeewD19bO7duGWrBs/is38h6mgeUH0nw/oykn/clozFMJPFJh7OXlf
	YrKXyr6XUDKYKJvU+Xd0PPXuam0+MkKZFoOqjt6RmtFXmonp+ozIChhPtsiygEbV2wuUE+qaup6
	cmNTBqjY0BEZ7/0byAXSQd5IzO8UFnqaYnQ9kX42Bf7//93+eywzqRBHDgq1mjxU6g7a/VYGGge
	VtM4YRoAo4rNbEIDq7J2H2U2f+whB+EZWI1K07gAc31WM5dUTJbVUJzJuIyvRp9lTvl8/tiKRbb
	1XO5uU1Dy1q+aveD8iQ3T0d2/LSunaYOgg20ESVcMiiuXGDEr7g8M7Abg095+Ew306Kd3vSjts/
	Q9n6KNMVfv5g6rgTUKFjIuIPCrlAxqvWJNQoj9nKOH3s0c/+bRMfio/Yj2IOYDODv/9so8R4AQE
	QPJTkgrJGb16hgWtta2tNEJwkR5mU9r/fFwxd2CXfO2K7nU+DU6XHfxF9F87gU367aM8U/9tx9a
	8SeQw==
X-Received: by 2002:a05:620a:1725:b0:910:c8f5:3e43 with SMTP id af79cd13be357-911d0e500bamr547302185a.57.1778845890470;
        Fri, 15 May 2026 04:51:30 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba18132fsm527816485a.6.2026.05.15.04.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:51:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNr4j-00000007GvV-1Jc7;
	Fri, 15 May 2026 08:51:29 -0300
Date: Fri, 15 May 2026 08:51:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	Cosmin Ratiu <cratiu@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] IB/IPoIB: ndo_set_rx_mode_async conversion
Message-ID: <20260515115129.GD7702@ziepe.ca>
References: <20260513124519.3357165-1-dtatulea@nvidia.com>
 <20260514164219.0cb832ff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514164219.0cb832ff@kernel.org>
X-Rspamd-Queue-Id: 8369055002E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,intel.com,gmail.com,redhat.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-288290-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 04:42:19PM -0700, Jakub Kicinski wrote:
> On Wed, 13 May 2026 15:45:18 +0300 Dragos Tatulea wrote:
> >  drivers/infiniband/ulp/ipoib/ipoib_main.c | 8 +++++---
> 
> Since it was tagged for "net" - can we get a stamp from RDMA?

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

