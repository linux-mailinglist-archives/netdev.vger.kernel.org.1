Return-Path: <netdev+bounces-83984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF8C8952DB
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A28EB2721D
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E67275813;
	Tue,  2 Apr 2024 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="D5h1znKe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F55D6FE24
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060582; cv=none; b=HDO7ejqBPiOpFX3FETi79nrkpvsXMhSPSA9lVHoscHQxkEMwHPXqWG4zZe+vVrh0hCjP4mmPaTDXkoJOC13YRGwnTOa1IsD9dMnt5zHz4qrCeiQEcroUtQN5hgTbCyxRBQB5IeyiC+3vJYbaTHkIRp7MY1Rb5OhvEtCQP/mE5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060582; c=relaxed/simple;
	bh=mbQkOL4j8TAxgxaiur0s+4odmPmLL8jNl5O0N2Gbx6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWikp1X0yqBr1TKbSjtdAjW06JK4Cg+I7xcc97y+tBYmbAmnDVMcMjB3sZDC1XsdFgle98tSfUBLvid7aJv3cOtPCMc7BEGxlbcsvhWcFcTf9ajbDAqttLpt76Ci3SMek5chNv6FcWdSsOu+WTMfnlmYDavMqpMSVciGT4BrT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=D5h1znKe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-341d381d056so3365962f8f.0
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712060577; x=1712665377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hyNzutW1FQE4t1aQ4mfpd/YSE5qsNE6pWpPL5goeFFg=;
        b=D5h1znKeeJfViZNxUPoT9GEfmzEqXV7XPGNIqcaKD+gVSEVEwFtRZNIEdwzgzLyLs2
         CF4XeCki69bduHJhv9XyxRUIi49wnczRDK9zon1ZC5nX6/uXOiXnsVO9EMkcnidNp1ow
         Rw6amyyLZExblrVdPhq5S0s0063l9/mIiSOk8XBxc/bdtUv0Z5jrUbp8cmEpfVT9bwYR
         Oz+eslpGbI0+V1cSXLagF5n/9VyhpLPoz521Fc/EVvT00oGU8/6N06cpT1JYzi2UxZLL
         v3r1dOEOrFHrk8oBE4hUIS8DFlur3JSd6/cty0oxzvsNeOzrbjcmdrud5/SsJdV0niYZ
         XiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060577; x=1712665377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyNzutW1FQE4t1aQ4mfpd/YSE5qsNE6pWpPL5goeFFg=;
        b=aHrnMaG7Q/iRWAYOrZpPYf2Nu8jY3x8kPrBRQe1c3u4eRK7+jQfHIBvbcgUiIA6iZg
         Wh+zKHMjcUCW5oojbWmLKdPXuaDfjlqoL8MXiQo9JpJTeMzYBg4+Nf4nU7nwROb6JhsN
         PAs3IW3j2kU/L7vbKPV2NSFfpGSb71TkHrYZfthYXcwm0HsPMCxVmyI3vlItFgXlZmxH
         m9dacX1AgkEVxRfz7GpVqd9CCE3zk5DK+SVvjH2C4q0qbqkRleh3vjlTQSIxkbwlo7jU
         5mrLNpG83ZJfwoPuWS6rUhI02EJqSfHb4iMui6kBvHXd3RqARL4CnDWY9UfbPxPMMQgZ
         kurA==
X-Gm-Message-State: AOJu0YymdikZ1zsw4KniTzHP8j0DVq3Uat7w/M6lbjcBqJaO+UQ3HFNT
	jIkB4HUmGauWOEAb0KmcfLIdMvi8vZ7MPG0ip2ME2Xpc/xancFFMMwkAxmrsAnY=
X-Google-Smtp-Source: AGHT+IEzHmxKqdfVU/diHTYxIgjX4CQovk82hIat+prg79lMhsBnYRwPd7+z0+9NwtZvlA9K/H5O7w==
X-Received: by 2002:a05:6000:1887:b0:343:472e:cdd1 with SMTP id a7-20020a056000188700b00343472ecdd1mr6978812wri.69.1712060577242;
        Tue, 02 Apr 2024 05:22:57 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v28-20020a5d591c000000b00341d4722a9asm13987679wrd.21.2024.04.02.05.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:22:56 -0700 (PDT)
Date: Tue, 2 Apr 2024 14:22:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv4 net-next 1/4] Documentation: netlink: add a YAML spec
 for team
Message-ID: <Zgv4nfZzH1mXAByx@nanopsycho>
References: <20240401031004.1159713-1-liuhangbin@gmail.com>
 <20240401031004.1159713-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401031004.1159713-2-liuhangbin@gmail.com>

Mon, Apr 01, 2024 at 05:10:01AM CEST, liuhangbin@gmail.com wrote:
>Add a YAML specification for team.
>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Small note/question below.

[..]


>+    name: attr-option
>+    name-prefix: team-attr-option-
>+    attributes:
>+      -
>+        name: unspec
>+        type: unused
>+        value: 0
>+      -
>+        name: name
>+        type: string
>+        checks:
>+          max-len: string-max-len
>+          unterminated-ok: true
>+      -
>+        name: changed
>+        type: flag
>+      -
>+        name: type
>+        type: u8
>+      -
>+        name: data
>+        type: binary

For the record, this is incomplete as this is not of type "binary" but
rather a type determined by TEAM_ATTR_OPTION_TYPE.
My rejected patch:
https://lore.kernel.org/all/20240219172525.71406-7-jiri@resnulli.us/
Makes that possible to be implemented in ynl.

Jakub, still not willing to pull this in?

[..]

