Return-Path: <netdev+bounces-80377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC43987E8E8
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17891C2152F
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBCB381BA;
	Mon, 18 Mar 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gQCeXeCZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0068C376EB
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762631; cv=none; b=l6C7k+aZYvpd+JBBOY3uASe5c5SmXAImS7V/Fv9s70Yr/J0K0MZuFHNEES/Uqj0UUWHPxziOVHulsBOGmGK8S/+zFW5QfBxBTnnmCmzRH+3KHyqslTT4hyTfsbHP/l6Gr4jvrFk9d7vIYRakwhIM223tXG6Th5wEdYs81DCzLUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762631; c=relaxed/simple;
	bh=lU9bMWiIW1MDkwJWy8LBqUJP5WHwZqjn3zXsS2kltOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/iTdiEVRKoJO0/uF8y6XCvNXXDr4Y5TphrIXKVhgcSV992sZdI6nTA7nCWgFRhN4SeiEMN0l0sbC3pbwpHv5cUYTvD7jX+hEYAisvt+5lUJ5Xrbb8UTy3IuCCdTM1oQA6KuFlcSmDeI4eSkbzA+W1HiOrn82+RIHvqyyYnm+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gQCeXeCZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a466a27d30aso546746966b.1
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 04:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710762628; x=1711367428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nlm7xRdDFc7fauAnErY+UzfuMmkhK0Kne/zdC/bB/+U=;
        b=gQCeXeCZ2ZkqCp4ZXrDlaqlnNvxtMzN7H+qRZHjgS6WiaZLavl6kFmnPc+sfqO71x+
         GcoLc5GGX4Ic3GAdsLzfAt7AQ7tRXwgy0bLFBevMCONVAiH0kazCiQ+fis4H48L+vAmd
         kmrZwuYJIi0e0LWbGnmDr9Nc+UqV/vAvtAiy8OwOZrJ40CPkmNjsn08ne4Vt5G0fTA77
         WWzPZhdDZn0QzWdQ+6KrrvYCh6QrlB5OK703s5Yb7HVgvws23BaQoOBU9hQaL4KVA8fg
         DXiLLYeLoEYMXl7gu9Sxf9rhrx5PE4vZjfBVjv+pRRnDwnclz7IaPqx0m+3bXo3h8WFE
         0oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710762628; x=1711367428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nlm7xRdDFc7fauAnErY+UzfuMmkhK0Kne/zdC/bB/+U=;
        b=Ixwzx0oZefSPCh7WGZsQkD7vRTMEggR7xBe23RewrbPVma8tXZJ/qD+kFHTYjt4jed
         VWI+MprIgNhnCis/AuUsNLzqti/Sf/1ejOK2gugxKVDhr9DApvb+m1I0EllIBGj6nAxP
         bbV0OG+sDFw7rW4CC5NouA4YbLYGngmDTsHo0ZfINtlHmkArE6O0+8LmTqdnszGnJ9Sw
         IkBZV3BB5TeSBwLa2Z6HbQBFKHuR0fZg/A3NKJapi0au4cm9GFw+gtNwr3sBcakU8h3y
         2TJXQxmfI1h5l5GmZWchvmFLCopCcy0paD5Z8SEVNL6RGj8sLB414HtA3LHB3F4rhlz9
         zgLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8NoIrgF6LDSIQ7iA6cwZ+vlgmSH2oNboXE/9wQUgwWsafllxv3lMECzhmGagvkMP+CMo+Sc4NnBa8OjnYHHqeAj8JwbGj
X-Gm-Message-State: AOJu0YwldCvEK+aZZhNSrHIOmXqayNO1FOC6IYKhHk2pEs2lQiz3z1xJ
	4bh1hr7mcztdHKjsEO54P5RNcbyPyvng+1gwg0ehCwcLDhiXbZq3/N2YHVzFz3k=
X-Google-Smtp-Source: AGHT+IGiAn+Eg7DhkpzY6jXtyTpDXvqRaa0fsM3SRO6I3j8JAbiP4OKgw+Ce1c8f1fxxd3XjEvQ7hQ==
X-Received: by 2002:a17:906:6c9:b0:a46:ba8f:bcd4 with SMTP id v9-20020a17090606c900b00a46ba8fbcd4mr1992000ejb.46.1710762627968;
        Mon, 18 Mar 2024 04:50:27 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id jz8-20020a17090775e800b00a4644397aa9sm4757192ejc.67.2024.03.18.04.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:50:27 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:50:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Thinh Tran <thinhtr@linux.ibm.com>
Cc: jacob.e.keller@intel.com, kuba@kernel.org, netdev@vger.kernel.org,
	VENKATA.SAI.DUGGI@ibm.com, abdhalee@in.ibm.com, aelior@marvell.com,
	davem@davemloft.net, drc@linux.vnet.ibm.com, edumazet@google.com,
	manishc@marvell.com, pabeni@redhat.com, simon.horman@corigine.com,
	skalluru@marvell.com
Subject: Re: [PATCH v11] net-next/bnx2x: refactor common code to
 bnx2x_stop_nic()
Message-ID: <ZfgqgKK_SuvbOXnZ@nanopsycho>
References: <20240315212625.1589-1-thinhtr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315212625.1589-1-thinhtr@linux.ibm.com>

Fri, Mar 15, 2024 at 10:26:25PM CET, thinhtr@linux.ibm.com wrote:
>Refactor common code which disables and releases HW interrupts, deletes
>NAPI objects, into a new bnx2x_stop_nic() function.
>
>Fixes: bf23ffc8a9a7 ("bnx2x: new flag for track HW resource allocation")
>v11: updated with coding style per Jacob's suggestion
>     this patch targets net-next
>
>Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>
>Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

net-next is closed. Resubmit next week please.


