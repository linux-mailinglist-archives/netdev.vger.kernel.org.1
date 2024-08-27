Return-Path: <netdev+bounces-122461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04920961678
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DCD1C23768
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B77B1D0DC6;
	Tue, 27 Aug 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWXom8Zd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54871C4623;
	Tue, 27 Aug 2024 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782122; cv=none; b=Yq0wPt2K2gCoBLNQDgQgyGlVoK1q6diDjnWh46w/Rj0RTzc7IHNR58/Sg1467mN5qAiz/wno0ALFE0u3S09KkFQRj91z8pOdGJk57DjM3J8bNwLNjOb1iD+oz/jYwLLjSPoA9h95dB1dL0JRMdok9IS7XSzEhjXPEwdWub2FUDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782122; c=relaxed/simple;
	bh=22pIhycuEtbszQeF+te02KI9pX61X0zdFhoxqtctL80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4D0xQF4+oE7i1HGh/hs+2b0rmHEuXWkd3V/xFtecjztN6XYYcCIsfTGryvjW0b/m+PLrnEj9oKO6DXYQD+G0EDrAc4wtDOmBa2eiAqxj/bqgMNLvKxeYdMHm1tbqyQj/6EOCWb5b5WHEP8ShL/Xb7bifoCXSJIi3BSxlWFF+Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWXom8Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80550C4AF16;
	Tue, 27 Aug 2024 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724782121;
	bh=22pIhycuEtbszQeF+te02KI9pX61X0zdFhoxqtctL80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWXom8ZdReygc1z6FSIC8wn4FbwBPJHkG5YqBQgJcaZtaMlqPWI1b+5Feq9rE+rrK
	 L5DZDE7Re66entafjKjvqzzf+0is3yF9UDDNkwUj0i39BlELIXTaFPoRHqq9fN1E9C
	 e++ZPmw4sUATAtooHX1JHYdmI6+Wn/+jgL1VX4kLFjam8qrERZpremmAs42VHzKZ0a
	 +UrtUh2ueaEXHymvvvzIjvBf5DLKjFx4Y0cDcVKw5d98lelTYfG2/LqaAFNNTo5Kj1
	 nkFzHOmBKYRB9JSQsWx6a4iktM32kJI89oxzRmim6msEuNF7CEHcnowJLs3hezk8k4
	 7jJOgvZYRmYKg==
Date: Tue, 27 Aug 2024 19:08:37 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RESEND 2/3] net: hisilicon: hns_dsaf_mac: fix OF
 node leak in hns_mac_get_info()
Message-ID: <20240827180837.GU1368797@kernel.org>
References: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
 <20240827144421.52852-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827144421.52852-3-krzysztof.kozlowski@linaro.org>

On Tue, Aug 27, 2024 at 04:44:20PM +0200, Krzysztof Kozlowski wrote:
> Driver is leaking OF node reference from
> of_parse_phandle_with_fixed_args() in hns_mac_get_info().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


