Return-Path: <netdev+bounces-240423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 304F5C74ACE
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2E90E2B61E
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAD833AD8A;
	Thu, 20 Nov 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EaEoyWdu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BA73346A5
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650392; cv=none; b=GPb2qlo2aZJNy02rXSOCNeKO8+WCKOYnkUC/1na/I1giZw92Z6dUmqARxqw3rlBcl9+MQcBMldL1ISJPM0lBEN5g56eWOSflBteUCdFGM8PCyY7lHvQFIc/UP1yg/KIpIe4lwUQBRSxYU54q8ChYmALnFhNi8Mx/f1TsDWXOSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650392; c=relaxed/simple;
	bh=Hs8Y4srjRXSDmflQe1JQvRGbJo0svHHlH0JZJV2BibQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTMT1RWZJJY3VCV5HJM++1bJwGqUUIGhnNsKU0AYdIK9LuIHpVBgfx2wVq+1BLlTpyyTPBfHzAgz51TwRtdNWQacqcfXwrpf0Mn0qhKXRvmgvq+zP4Nrj7EN6zp1S3dVMCuntpsxxpfTqUaBSUMF3PQq115OQAP8Ejd5vL/a/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EaEoyWdu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so1655546a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 06:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763650389; x=1764255189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hs8Y4srjRXSDmflQe1JQvRGbJo0svHHlH0JZJV2BibQ=;
        b=EaEoyWduEzmqyPeavUzgsFNnUa7ir9Ss7/cVWRn4tjus4OhJKWgyF+0XIXHnu1PKd4
         ZkzflYIgmcJDHZ0qX5Npw7D6wHNNxqPV44h7J7tIyCjH5ZImw4jcvi2k991pzmkZEvrO
         OnWUy3G25q0tA4OuOcOwvtGJIwlta9AygvQT/w1Z7xYEaQKop0p/1qUInMDgwNBqcQg4
         CzQu1QIjvb6Vu2d9sSpRb8IZqOe/09zCLS7uKkue3xlvCwZJhU4CyVOyaxfFQy5MuoTR
         /0uX0b048r9IcFkw1BjYGdNbM7f6zy0t/mY94T60GiTjfgl8Op7PQJFk69vz+eekH8l6
         uSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650389; x=1764255189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hs8Y4srjRXSDmflQe1JQvRGbJo0svHHlH0JZJV2BibQ=;
        b=OGfCxSa5s5J/d9Yzscvy/bnHglFp7mktJeIHmyLnqB3CseSiXMt5iDBR2vUSr/Vguh
         cx+miY1BTboH4Io7WZUHK5pvybGqg6KEMGZEJtjNL9YY+MVA3qujgptkkgifxqaXuAXE
         3tUz1gJBtqhVst+B16pMggZ/N6VUSXofS9uQOAqatvqQX4QBnqVLFNhDA0KOmnCbItE+
         WZFM4IKF43ijWMziPTKB94wed01XlhmplUiAQWT+jqJxKjtm9uKXChemXbqgyTz9coE8
         KESzFUOPwDvRzjc32RfpEeDIK2bcSxJgb261liFbf9Tlqn+9rxEkCGx+eUrzFUsNObLN
         p53A==
X-Forwarded-Encrypted: i=1; AJvYcCUb4cg3YEPVzKKoEeI98X+6VTgCH+PQFIDJ4joY1M21MELitkAT9fsz2MCb89N1Yq2idpabPP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Lu65eiz7HCSD4jA+OYjOhRXI0S6Tnz2aJy0m8fh5p5mz/rAJ
	Bk63GEt8wRSs0ESYSSS/3oVXInGCIdMT7Vy42XDZY0Dq1AugEg+QA+ExvamC054hANY=
X-Gm-Gg: ASbGncvZY92ieH6T89AOdn92jpuyGKGU1HNaj5o9+7oaeOJbc7jwbnZ+6TuqNQjqdqx
	l1+JWX/YCXhK1e2S25L7GVNPvCt8LoRf7WZ+l1MsyGIezT9MASkH3iol/LnoMMZJjQceFgFYZEV
	Efic86+DdHnoFqP17CtrLCPgV7+3wgjnsbOjp8NceNKHClKan5SSjphZFOV97qvfZTBCB+ZPQMe
	i0D3rR6LmJP9yOZvGDhOQXzpHFUQXfDRhGaaVTfem+pxRsYSL6KFh6vCi2CurpD8VWS6Vz1BOM3
	Ocwc/+9YKQTIF9EVE8gEKpPHbU6HiqA/SY2HRBOtXC9t1rIIfxIaNHnDfacCulZUdA59cerf2Up
	aTeGkfSurISfjV1yc39WhDokG6QlS5WEM9/BgcU3GDh4yxaXX1VLHplopN743WeGQumRFbM/uW1
	vxW3PSQdybYCZ8Oiyk9zw=
X-Google-Smtp-Source: AGHT+IH7CoEyCVFu/qkrb/nXh2Nvt6ZT+I/QXVymMAmlXeUbqUpzFWKvc2NGr9Yw1jk0rVm9T4o5hQ==
X-Received: by 2002:a05:6402:27d3:b0:640:ebca:e66c with SMTP id 4fb4d7f45d1cf-64538227960mr2444296a12.23.1763650389157;
        Thu, 20 Nov 2025 06:53:09 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536443a9csm2243827a12.29.2025.11.20.06.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:53:08 -0800 (PST)
Date: Thu, 20 Nov 2025 15:53:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 04/14] devlink: Refactor devlink_rate_nodes_check
Message-ID: <jpxxt7vxoltrf6r636rch4cd7tbharffrlgunsjfgnlud2lmx4@em5lcb5zhmcl>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
 <1763644166-1250608-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763644166-1250608-5-git-send-email-tariqt@nvidia.com>

Thu, Nov 20, 2025 at 02:09:16PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>devlink_rate_nodes_check() was used to verify there are no devlink rate
>nodes created when switching the esw mode.
>
>Rate management code is about to become more complex, so refactor this
>function:
>- remove unused param 'mode'.
>- add a new 'rate_filter' param.
>- rename to devlink_rates_check().
>- expose devlink_rate_is_node() to be used as a rate filter.
>
>This makes it more usable from multiple places, so use it from those
>places as well.
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

