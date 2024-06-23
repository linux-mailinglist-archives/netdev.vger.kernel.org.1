Return-Path: <netdev+bounces-105911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B929138C7
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 09:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5FD1F21C2C
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83132BCF4;
	Sun, 23 Jun 2024 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khMMwg0E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BA7462
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719128067; cv=none; b=K375qaFKY1PMEdAF4BvViAUGHWSRlVLKHrX5ZmTa9oD5HKTqzdmAOREO7MgCcHwRBFeGz69hAk7cArSQzoFI7DNC7ssyxqfnjF4EEHGZw9rHiVW7Hd3zIpIAWJ/uXc04DxJ8jPfLy+HZOaovcfTEunMxUJLKkTnuUsNhigdhr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719128067; c=relaxed/simple;
	bh=iHWjYoGipNb0g4VoVGpbivzU1qPw9RglcP9vHncefsU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GAMHu6RLKow1OhLFqtW7iPKiWI5pw7AwjpjwM/cqVD4u2B+EsTOeV9AsSW6fyGH0ric5JiSLqNx3azEMf9a9MkSVXLFBxS59tQzAwOyZM2Ia9aVyz6xi3y3bgImMSxNuh3IiVe7W+8OAa4mxbc96zHIpDZPPfj/U0Oa77hPJ0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khMMwg0E; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-48f49d1e660so220694137.0
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719128065; x=1719732865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF5RtNqBAFx7Euk2QnPiBTH7XrxgujaFdq7zqgcriWE=;
        b=khMMwg0EKEBva9PoC6k/j+hC6cwKaK7g1RKI0mkAypou6oX3gp5bNu2fgRC6pzcX6E
         ejHkWGPs2gugWs3MFHKnJlyXhZ8LSE/h9yB4NjuBbdy+BDdzurrrKj6O2yEJyzz2SM3b
         A1/CN552iLqSfwK9H7KMxJODomc9f9wKF4Ht2hDNFWkVpYnFiY+V0bVEeELPW8w/F+rN
         oRuGq+3CsvpUgugeH1S/QluI7cBsRTMNa1yVRrqGokeR0BRD7cEbB7s1cwiiMNH5Iiqb
         kVGCpe6sr9Vo+13xe3Q9/6rAASzZGCeqmJUqOtoMDkvcDfjTJTxIeXOI19A1SSdwGqJy
         iJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719128065; x=1719732865;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cF5RtNqBAFx7Euk2QnPiBTH7XrxgujaFdq7zqgcriWE=;
        b=vdiE1R1pq7sKgLufJGaImjOXja6JnS3RRltRMsMD/xJ6Hi//HNEcgGU1duQFP0ADlj
         CclJsjy5tz/3Xh/LQ00fCa6/+kjWuZcZjvpCh3EHLJpTv2QXbFHQY185dYSqGheoUzUN
         0tOBksxFSWG+LkM8oKeqr4jIGwlTtZDM2+JlVjQtP456/7L33h4UUrksVM5GxT3A0r3N
         UqFJLJqhQizMcK3cfoaO7HVn95ULZBgjTelQox+WuAMdp5wuESMGdBoRzUo1anOOvdRf
         pcrJQWI9RwIPklXnzroyxMU1al7MSxraLRiKijpwHZATJb/szWljr4HfXoDVesWBOJ+5
         fDOA==
X-Gm-Message-State: AOJu0YzaXCphE40PoovDSTNzkEqBrxIqzFfbJOKCvmyMU8/2p7tVAvnm
	vHdlh8H7lgjBdcRdKiRoX9u8HL0fGVeElhknzJ+FD+yT6XbQcld0
X-Google-Smtp-Source: AGHT+IFFxAHrnsnEq90qS+hjN9rKEi3ka9txUpudqQxXXM1aKjH7aEeJ+WZ5ZgGE/BZDnqdlYGbQEQ==
X-Received: by 2002:a05:6102:2423:b0:48f:3f73:bc2d with SMTP id ada2fe7eead31-48f52a7e3b5mr1087925137.18.1719128064852;
        Sun, 23 Jun 2024 00:34:24 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce91f8d8sm219337185a.84.2024.06.23.00.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:34:24 -0700 (PDT)
Date: Sun, 23 Jun 2024 03:34:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6677cfffbc25a_33363c294d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240620232902.1343834-2-kuba@kernel.org>
References: <20240620232902.1343834-1-kuba@kernel.org>
 <20240620232902.1343834-2-kuba@kernel.org>
Subject: Re: [PATCH net-next 1/4] selftests: drv-net: try to check if port is
 in use
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
> We use random ports for communication. As Willem predicted
> this leads to occasional failures. Try to check if port is
> already in use by opening a socket and binding to that port.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/lib/py/utils.py | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 0540ea24921d..9fa9ec720c89 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -3,6 +3,7 @@
>  import json as _json
>  import random
>  import re
> +import socket
>  import subprocess
>  import time
>  
> @@ -81,7 +82,17 @@ import time
>      """
>      Get unprivileged port, for now just random, one day we may decide to check if used.
>      """
> -    return random.randint(10000, 65535)
> +    while True:
> +        port = random.randint(10000, 65535)
> +        try:
> +            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
> +                s.bind(("", port))
> +            with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
> +                s.bind(("", port))

Is the separate AF_INET needed? As AF_INET6 is not IPV6_V6ONLY.

The following correctly fails in the second bind

    with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s6:
      s6.bind(("", 8000))
      with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s4:
          s4.bind(("", 8000))


> +            return port
> +        except OSError as e:
> +            if e.errno != 98:  # already in use
> +                raise
>  
>  
>  def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):
> -- 
> 2.45.2
> 



