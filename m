Return-Path: <netdev+bounces-219336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E09C2B41053
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9246B1B2723B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCA0277814;
	Tue,  2 Sep 2025 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFRhjB9S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F32773F3;
	Tue,  2 Sep 2025 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853370; cv=none; b=BfbhdUG5gyAi/VlcdvNjzboc6kykdGz2k9MGfC/sIlgRL6uGE1ROx2/18sXohpSvmGAp7hMK0/Y9S5crts039sN3Rw5wNqwoLv+ccnciKSZoZWA4OLnGbDbCObVtocjJhFbScjiLQlMHXA048HONNSTMG2PWd3ag1qIFuv2aNRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853370; c=relaxed/simple;
	bh=x1fYtz/DGQkJOfME3HltG5aYcqAWCkzmIqUC3vT/gOk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pT1AlvwSyXiXHY1JGnCt1MBb9MZsUbahg3RadSrJwCnotzBau/fdFfPhARZ6cdI+yG/Disdv/amJj1Qgb7xSDuYhB/uPIKdYetECUZX3wZptT8YPBv8UoNBg695NVsWratuejuoBi8XOzBKOcHYsih5feV1nwnZda4M5zCXRqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFRhjB9S; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b32ce93e30so20056831cf.2;
        Tue, 02 Sep 2025 15:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756853368; x=1757458168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/r8KI96FLIsXt7BTzjZmeT6WOrie+H7TpW2dI0xAa0=;
        b=AFRhjB9S+M95ZaqQwI7oYICqXFwfs6r02neYMtN8ZaKIbns41aA2Z1Tn4FQ+j1+MAt
         1ZclcJyboVaaQsLJMVQD84HZcEePgX5lpByW/hRbppZFKHBzlXjelY/ETrTeTSNneW6c
         DfcrUMrkHmrXsTSLkb07C8vKDL384jtlQc+3n3Hi4OuRqkUIy8X9KAzdg0DeiNItd3uA
         IPR13/0tTULHY+SFLRNBEEHY/ZQHHIAvKSm4P5RSKEkqSmAJLd/JsDzMkJplecYvpscO
         FWT0QwoODmdZflIpaSaTQZdVBkjCk1wg4UHzxgrcz6xURhDydV8MJbEjjYzRSWFgxpP8
         KUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853368; x=1757458168;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W/r8KI96FLIsXt7BTzjZmeT6WOrie+H7TpW2dI0xAa0=;
        b=XcfKojpkEWTJhYml0TGGiocuQznGczu9erPqzLsWn1Q4ETVXpeMqKQELJcyDyZpMnv
         0s+YwWwzKp9xkZoTFMrT8xsKrAkaAcbSukmqHX4x/RdyMVIihDZJHQx0IDRXrjqSnMfS
         7IPV2duRgavVJI3cH2vJCfQcua2tR93Ep/LE7UJO9c1FHHMFdkOebRLb0078cumZv8Mr
         1B8BlvrUwoOspcwbe4A5uwGPB4auAYi2dJ0hxy1zUvhPOjpi40EWYO71SvLCaiiDvjRX
         d4VS9b080FiLAL9dzm7Kcq2cgz/lvg6el6mgTIu+1yUxbmb5ctL2pDc33ySuQpn6iYi2
         oOwA==
X-Forwarded-Encrypted: i=1; AJvYcCUtLJhTuHP20s7V31aEYJjNk17PEh5ztLysH1EcmS2I2Oy5/vqvBTH5dZ9d3KW2Ej2ly3SsNl5xVWzQ03U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxY6Auyat1p4rePNHoUWdaPkYnowbqZzPI8yVmLkcnhsCnmGk0
	FyDooe4j5vLUevvY6ZKvOIFXs6xfzvKVSCIPLCMBxdWrfSfP+41PrXmZ
X-Gm-Gg: ASbGnct5c3eB9vQxR3/GhIpsdowRfeDNPIbbVxwiluIyu8eUjrhl4kjIAWGEr6M2beS
	tgrwGqT0oOznbXkCdqr7Iaj2th4tlu7T+NKQHipOn5eY/DhSA32qWJSlOv1O1ONfe/UgDxJwOV+
	kjrgOb0dKXWKX+jlcclCNOOqFS6zBHlvT1iAct4eTkRLzWAdSzSBIbC8G0mius3tsJsp3knLZPm
	nKYkytxW2Qg2nSFsN0vSgxmrpVmKT9W1gjdqklJfZ0JG4BEq7aHo9Wd94ROv6RzSqUjZU4SdF0L
	Fxem/qFxsgci2c8aYgPeZzNm8ZfB4f8IcnAph9ITIiMLJqhnXjXTH3H4HhFN0tFMJdctsyBka/Z
	Xr932TpDAhgqYGTqkMU9UVJHabiFcoXJmzzPn+MSMo8sTveNoVnYr0vVanm2qDywfUQuDe7WT+E
	W4glmtjlcho8/wv/964n4GN1U=
X-Google-Smtp-Source: AGHT+IH46xUXV484hnHXmXzWd3NGpG10mKGi1xfUd31g1IcLmOmEJG4dfsIDEM5/R7lCxuphIRt6qg==
X-Received: by 2002:ac8:594b:0:b0:4b2:eeed:6a17 with SMTP id d75a77b69052e-4b31db69339mr165830391cf.46.1756853367702;
        Tue, 02 Sep 2025 15:49:27 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b48f7823casm2163821cf.42.2025.09.02.15.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:49:27 -0700 (PDT)
Date: Tue, 02 Sep 2025 18:49:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 kernel-team@meta.com, 
 efault@gmx.de, 
 calvin@wbinvd.org, 
 Breno Leitao <leitao@debian.org>
Message-ID: <willemdebruijn.kernel.2c7a6dc71163b@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-3-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-3-51a03d6411be@debian.org>
Subject: Re: [PATCH 3/7] netpoll: Move netpoll_cleanup implementation to
 netconsole
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Shift the definition of netpoll_cleanup() from netpoll core to the
> netconsole driver, updating all relevant file references. This change
> centralizes cleanup logic alongside netconsole target management,
> 
> Given netpoll_cleanup() is only called by netconsole, keep it there.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

What's the rationale for making this a separate patch, as the
previous patch also moves the other netconsole specific code from
netpoll.c to netconsole.c?

And/or consider updating prefix from netpoll_.. to netconsole_..

Just two considerations. Not blockers.

Reviewed-by: Willem de Bruijn <willemb@google.com>

