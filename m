Return-Path: <netdev+bounces-136417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 561C69A1B33
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBEB1F28AC0
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854E1514FE;
	Thu, 17 Oct 2024 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGzF6u1h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8115C13AD06
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148435; cv=none; b=OCzsGSwxLFmsIMMsu+oOelAOg3dPHhTJGpTElJh92ViNh4qQiG6BNyGxT4jnfcbmOikHepD1icI3FVHiMir6j2Q+Vl0iEyjx8pTCUU38sA2DoOoz8H/DolT3JUQJuIRYJTpCHKry4SonjQ8wIn0fjNfcbxFLbgxhrDJaKTeRQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148435; c=relaxed/simple;
	bh=zVB7MIjt8E1rol1MkI6iFH9vfznyNP4ye47V8aOwr0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkAaz9MKIk+JD3NEu+Ze0k66aQ1crIrYX/kldsEAakMGz2/Tt7/naY0gfWNhJmqz/M4YgChqtJ2oGzjAytpACsoN2WXIVkGRGFjKukG+bOy2wJZLqGmmo3sGtF/jRx/bTPbFx6mxhfbW6S3yEzEJ0hdbRw8qPNO6//dcLSD1IaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGzF6u1h; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a04210826so12798666b.3
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729148431; x=1729753231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V/QR0p9lG25pQUZZGyopS3hBl+uwDPRWgXalwipVrlw=;
        b=AGzF6u1hbBaJE70rAtrCwubKMl9lGyJSb/sKAC6AeY0PQr7q/4bctbeMWyDFnKdJjD
         J6IeZjB5+HZ16yKNn9MQIMRn2uCTgRxHt3JeksWF0D0l7v8VroKwmJZetCuTIh7GhvdV
         gQD7Ubtd/lQ08GlRajxMwa5Cz338J4eWDpokYeeHzX1WxAGMo+G1+JQMGE+wi48vjFa/
         ujvYd/bDyxHrCJUVFuPQTBiEBLvaSTB3n+6zeoWYSu/aJFvycmUzJyjtdCS/HAsaM1pz
         5Q3iSMTOMAVfQZJLdZhudiKwYdfgLpHj8Sba5utg2JMR9eBw5MoUACPXVJiyt9Pl6ahr
         /ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148431; x=1729753231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/QR0p9lG25pQUZZGyopS3hBl+uwDPRWgXalwipVrlw=;
        b=C9WuN+UVo6mTiIvnHYXlOkB+hkTDibl7jCCMvNKcNBZCnIGLQsIUcNRijCCKEms/PC
         QaVM93ZOS7Uvy/wzQW/Fder323XSmlOQBRMmLbyBHxxSpgvsHJixXZyd9c0KFqqvGhY5
         I6RQDMRmmRIGqo8WrAUZ62u4HQddMhK7JNPR2PCh8ZIzcJRUzUTt4q50fawLrBc8HcOT
         M5OABhR7s0pRS/LEeU9w9qujwJ3TQ5cx7bohrdnMW49Veu5yJxsLdJFMFYWz+YYZ+FVQ
         99bdDQVKGRwAuSG0T6uY5xE+n39/ooOiFbmpX0Ut/U/nWOBc2MIyquFEI8jDHGs8Pl4H
         2+fw==
X-Forwarded-Encrypted: i=1; AJvYcCVXLf/PlLid/kitFZjCcgXKauTTdO0Q+0Is2AZH4d11xg2/O4eDX4NsH6EFZA0mzsS0TNU5wmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygTukCaywAv7YlsyJAjePym3MZh/o90MxB2pcEwiijO9rEpMk+
	Qtse0yGkDywApAoUCghBp2bWb72WioAwLoCEgKcwMRvUbaq/D0FM
X-Google-Smtp-Source: AGHT+IE6VaR1EYVUDvRBSIOs9IrZ+LncOGzJe1aBzRjtFMXZusFajEbqduuy9wblaid9znfy79cFag==
X-Received: by 2002:a17:907:9485:b0:a9a:3c91:5e2d with SMTP id a640c23a62f3a-a9a4ebb33f5mr81195466b.1.1729148430151;
        Thu, 17 Oct 2024 00:00:30 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2988c500sm253567366b.203.2024.10.17.00.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 00:00:29 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:00:27 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 3/5] net: phylink: allow mac_select_pcs() to
 remove a PCS
Message-ID: <20241017070027.3vt5eydezrx5d6ke@skbuf>
References: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
 <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
 <E1t10na-000AWc-M6@rmk-PC.armlinux.org.uk>
 <E1t10na-000AWc-M6@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1t10na-000AWc-M6@rmk-PC.armlinux.org.uk>
 <E1t10na-000AWc-M6@rmk-PC.armlinux.org.uk>

On Wed, Oct 16, 2024 at 10:58:34AM +0100, Russell King (Oracle) wrote:
> phylink has historically not permitted a PCS to be removed. An attempt
> to permit this with phylink_set_pcs() resulted in comments indicating
> that there was no need for this. This behaviour has been propagated
> forward to the mac_select_pcs() approach as it was believed from these
> comments that changing this would be NAK'd.
> 
> However, with mac_select_pcs(), it takes more code and thus complexity
> to maintain this behaviour, which can - and in this case has - resulted
> in a bug. If mac_select_pcs() returns NULL for a particular interface
> type, but there is already a PCS in-use, then we skip the pcs_validate()
> method, but continue using the old PCS. Also, it wouldn't be expected
> behaviour by implementers of mac_select_pcs().
> 
> Allow this by removing this old unnecessary restriction.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

