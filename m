Return-Path: <netdev+bounces-32377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C36179731D
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 16:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AD61C20B20
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C72D6FCF;
	Thu,  7 Sep 2023 14:41:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685966FC6
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 14:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71426C32794;
	Thu,  7 Sep 2023 14:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694097676;
	bh=GDw8VcMskclm+z/Az+gbb9bJJ9NFigeZLKwb7dJCYD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUtOwsEakxNgYZg8/7yCyRCOCoJXBzqIzBIEXEGJoa/K+MKI+vq9vDNe4effsQsXY
	 KSTGLcCpkwag5S7RHWoxdc1DT+Uc1/pDbBLDcdlbgGwCVsn3FnryV05Jt2QotuaEys
	 QRckSwD3xX+Rashoi55NASmCWSngZP1gYFttRusrO5WauwhHXmlFgV5F9gUCvPO21j
	 X0Hnxv5xA1XMz6wvKnIg7RheUuvwaGjvZ2+kLGB4+QyhYaRbeFm0wd6w3lHpkCOD2A
	 PXtcy88k9EwaCMwLv8mxy0kEgCM32V7BzzfdqkpEG1POqKCjpZQ6bmVEOafRBqxSbS
	 eUJEgQkGTkZnw==
Date: Thu, 7 Sep 2023 16:41:12 +0200
From: Simon Horman <horms@kernel.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com,
	"John W. Linville" <linville@tuxdriver.com>,
	Ilan Elias <ilane@ti.com>, Dmitry Vyukov <dvyukov@google.com>,
	Lin Ma <linma@zju.edu.cn>
Subject: Re: [PATCH] nfc: nci: assert requested protocol is valid
Message-ID: <20230907144112.GB434333@kernel.org>
References: <20230906233347.823171-1-jeremy@jcline.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906233347.823171-1-jeremy@jcline.org>

Cc "John W. Linville" <linville@tuxdriver.com>
   Ilan Elias <ilane@ti.com>
   Dmitry Vyukov <dvyukov@google.com>
   Lin Ma <linma@zju.edu.cn>

On Wed, Sep 06, 2023 at 07:33:47PM -0400, Jeremy Cline wrote:
> The protocol is used in a bit mask to determine if the protocol is
> supported. Assert the provided protocol is less than the maximum
> defined so it doesn't potentially perform a shift-out-of-bounds and
> provide a clearer error for undefined protocols vs unsupported ones.
> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Reported-and-tested-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>

Hi Jeremy,

As a bug fix, with a Fixes tag, I'm assuming that this targets 'net'.
As opposed to 'net-next'.

There is probably no need to repost for this, but in future please
bear in mind the practice of specifying the target tree in
the subject of Networking patches.

   Subject: [PATCH net] ...

Also, please include addresses indicated by the following in the CC list.

   get_maintainer.pl --min-percent 25 x.patch

The above notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/nfc/nci/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index fff755dde30d..6c9592d05120 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -909,6 +909,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
>  		return -EINVAL;
>  	}
>  
> +	if (protocol >= NFC_PROTO_MAX) {
> +		pr_err("the requested nfc protocol is invalid\n");
> +		return -EINVAL;
> +	}
> +
>  	if (!(nci_target->supported_protocols & (1 << protocol))) {
>  		pr_err("target does not support the requested protocol 0x%x\n",
>  		       protocol);
> -- 
> 2.41.0
> 
> 

