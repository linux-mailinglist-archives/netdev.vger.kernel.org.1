Return-Path: <netdev+bounces-53561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F01803AC5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB022B20A91
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7A72557C;
	Mon,  4 Dec 2023 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJft+R2s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D36B9
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:48:53 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a00c200782dso646323766b.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 08:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701708532; x=1702313332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TkRXka1ZcYRJP6LkcTWgfOTPK1IoJ/P88MIFv++L2p0=;
        b=WJft+R2sQp6qTTVUNHu3G6xoyO0v/P17dhxTDcvgemf3O6oJdU1JHTHQNlb0C52bC/
         wM9SQlYRlX8e0kZgf4FgaAC7CQEtxZjB26N61Q5sWKIux26OFippL/7mtTluqmE/M0Nm
         3Go91P4z5WddP3AV+sE5scHaDObBZdxl542JTDFJT4NbQ5FKXH5akcsKhJY3rK4aghGe
         +kLTEf61MXd1JonNr0SBG9URFTj7g9ZsICqQ8pG22RA/ml6WKiQIaKe28Rw/H9PPHAXt
         luHk9xwk+vZRIXI4D+9gbUmTAj3OjFEiVa2sVnZoTVtGMzvXJp80V3eb1AkxJsC0NqMY
         bMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708532; x=1702313332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkRXka1ZcYRJP6LkcTWgfOTPK1IoJ/P88MIFv++L2p0=;
        b=CwBfG7JBkt6RqrSx5NTIxp+0jfpJXkuAVu4fmc5d53i6o4qZ89C4v6ooYaa4spkOIh
         ei4vkMjFSIJTcI3rSY6tdfZDQaAJXPWkXnVhq0trLcsj7zu4SdJOPWNg5nPHBnBJxAP1
         4tOlza8XmMwk3gbywQeiLpmRcpPjI0T6bBk4A8pYrjAc1LpC7nF+PgS+zKJvc7gQstVa
         6hGTEt0RY1o9dzJjFcR773NnO3m2QmXQN4cftttS8KVpbFRGE/acyB/Rzf2UqBdK0vl+
         dJrFIgedWYeNlWy+klzKlhjlXcaGPduoANq5GgTczxiF41fgdjZs8J3w9yaCFQ1S+Ppf
         cnyg==
X-Gm-Message-State: AOJu0YyLe+FLNli9VERkvmZpljv9jyU0cJ7GL7esGKQMHfwAHyVJjAj8
	znyxdv5xBG43UmFL8wFJ5Pc=
X-Google-Smtp-Source: AGHT+IFTpDMsVG3AME1563rNKB2c1aWlnnDB9V2H8E1pNB0DGJQ6kqwHoiWs2Z8PevycgWel/51PTQ==
X-Received: by 2002:a17:906:6844:b0:a18:85a6:ea20 with SMTP id a4-20020a170906684400b00a1885a6ea20mr1666397ejs.60.1701708531755;
        Mon, 04 Dec 2023 08:48:51 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709062dc900b00a19d555755esm4371616eji.117.2023.12.04.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:48:51 -0800 (PST)
Date: Mon, 4 Dec 2023 18:48:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net: dsa: mv88e6xxx: Add "eth-mac" and
 "rmon" counter group support
Message-ID: <20231204164849.ireealpmeqjnwvoh@skbuf>
References: <20231201125812.1052078-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201125812.1052078-1-tobias@waldekranz.com>

On Fri, Dec 01, 2023 at 01:58:08PM +0100, Tobias Waldekranz wrote:
> 2/4 tries to collect all information about a stat in a single place
> using a mapper macro, which is then used to generate the original list
> of stats, along with a matching enum. checkpatch is less than amused
> with this construct, but prior art exists (__BPF_FUNC_MAPPER in
> include/uapi/linux/bpf.h, for example). Is there a better way forward?

Take checkpatch with salt?

