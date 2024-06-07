Return-Path: <netdev+bounces-101813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E19900287
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DD91C22E76
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D32190690;
	Fri,  7 Jun 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j23Vd2yJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F5190677;
	Fri,  7 Jun 2024 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760703; cv=none; b=REGd/ny2lx13wE1O9UMBOJdU2DAEZprLvRg1VCQVaAI/FYeWI5qlmRrm7rDrQ0OcuuOQxZ02Tx4lVIhsh+xFLeYnXCKcuiwyiTMdMNWtnkcWm3Nx8sj2Ow3/BnaLm4c8reSmh9QUDURiaU0ESINVy5zLuX1cxe829oJpMLCKFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760703; c=relaxed/simple;
	bh=oH7JSpB3Cd38sZyLfT7KUft20euD8fi4ppXRSN6PghA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB2uSyq8mi72R6SRpr//N9qDFj9lXr7APZ0BWTtQkC0vTkGtVLxH1zWdGinehyr7z13UaUUXdvLpvLBwZKWFGsMGhHo5mVvn5HlU1WBqad/Iu6CyVPchP9rw3+B0yraXpvxoX2oPOr47xUxu0dr7mI3lqXyJbGGS3qIdySxYS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j23Vd2yJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a526c6a2cso2309038a12.2;
        Fri, 07 Jun 2024 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717760700; x=1718365500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IoQecm4ayqWX0WKHZ3t6ORIyRBXsFm7NqUI7shHNHGE=;
        b=j23Vd2yJqEmI4hAY8ne2biN5WXtAEjec4tRLsJ5j/Zp+FtgRgeEWVP1hQsddLZASuZ
         /kHrFDo2dG8xmQ36gPNw7q3FDEX2REOWhfpuZviqdZFr2XoPfNI2ReKSFPy5AORHwU7T
         8yzHZ7XlNBcKEha9B0d/VDRhJ1hLjQFXiPhDCv8ETktz2zHA7sMhT9SXK58uPYZCwGfc
         tmLy6bS0gDX6pbBxKPPw7alR05T/RandozoC8C13ABRPdEUgnJ/ru/YHQ6dER6d8TAdh
         pdefuyEtUfjqGjCQIZFqABIrkIBVbXyMX7pphmyRS1zs6o0FpG4ZGB8erJG+uXE7VYnp
         x57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760700; x=1718365500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoQecm4ayqWX0WKHZ3t6ORIyRBXsFm7NqUI7shHNHGE=;
        b=p9KwZrZQjzMt1j26p0ULqUU5UeXcP0balOY8QfXdBUL2jr8KOLa9S5sG17auFeRzmW
         DDdp4Ue0ZbxGSiFWK1by4fKwN0gHh+cnrsJ4LEA2zf2Wyt6GAc2oZIxUAqZW/RLq3aKm
         GKUP8oqL72oBziZ8FI0M0tDAL+xKuWvq45nHh/h91mLNn2Sms9Gabw6v4+iZRD5zn9yR
         QFdZFyi0ouesIRTHor5rqwV4ImXlI+GPvLxSjQPI8uX9kilLjvpm5V8jzALMWgE1M9R3
         kSUGij49dpYRRhXI9Q7tm8QBefYi+PNsRfOw0Ak45LIOoH1Rp0MNmHEY0YaIQFTeZJeO
         X/vA==
X-Forwarded-Encrypted: i=1; AJvYcCXO5ksBjtDfUj8xOUXzrt2BIGbJ6grDqa5P0JwS8q30b307dvoDM0y2PqB/KEppx0zc0bs3eQeBr7oAmkXYtjvu7+8jy9wrC09h8U5c2TbaYQ18c7RjtYNe1go1kNw3h3aHfVtHGf1MfMIc7Pgb4cf/mxcLOJXzicTPWJjB3z8Htg==
X-Gm-Message-State: AOJu0YzOUKDWLQXsRfp1Tz9rdw0tro/tqUX7A3G+7d9pqKKFM7QY717K
	sJJMDq1+GBi1J/fS0/JA+dXBkBXFw+IzFsxLzFhPX6W2JavFbp6t
X-Google-Smtp-Source: AGHT+IFERkzOKrN8hPfwdgNs5OTSWrRA125xle8uF1PHtkoUGnXz1RZetl0nvFP95frkRyFdnkc6Yw==
X-Received: by 2002:a50:9b4b:0:b0:57c:5f88:d066 with SMTP id 4fb4d7f45d1cf-57c5f88d07cmr597884a12.8.1717760699756;
        Fri, 07 Jun 2024 04:44:59 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae201d09sm2617442a12.75.2024.06.07.04.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:44:59 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:44:56 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 11/13] net: dsa: lantiq_gswip: Fix comments in
 gswip_port_vlan_filtering()
Message-ID: <20240607114456.sm2wwtu4aqbyn3sk@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-12-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-12-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:32AM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Update the comments in gswip_port_vlan_filtering() so it's clear that
> there are two separate cases, one for "tag based VLAN" and another one
> for "port based VLAN".
> 
> Suggested-by: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Here and in whatever the previous patch turns into: please make more
careful use of the word "fix". It carries connotations of addressing
bugs which must be backported. Various automated tools scan the git tree
for bug fixes which were apparently "not properly submitted" and mark
them for auto-selection to stable. You don't want to cause that for a
minor comment.

