Return-Path: <netdev+bounces-28202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8091577EA8B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA12281C24
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11617ACE;
	Wed, 16 Aug 2023 20:16:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C508317AC0
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3AEC433C7;
	Wed, 16 Aug 2023 20:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692216973;
	bh=RwMfdQoVMocHV8lsm9MWMyQ8RwAc9ankzFYtPPXLPQw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=VTpMfbLkk3vKzcRHHAH+kqW0nDku7T7ICuxUnDpJw/wqY8DqklTKEKWYdpkzDtnvU
	 TzRQTx2kw+C7pmmYTYxScIlLU0AHH0rZfgYzYvLWpDfLnLGy9FHbrlTT/eQ5FNAzra
	 ZnN3WaWm1N/X2hedmAJyzM3ZJjIarXlCRI//ScRPWW/r+fhejxDWQqVpjZWE1ZsfA1
	 rfnm/3SEZTzDGn94GehDsfWWBPsMtGuscnscvNbX0uPzb64R/oeNY0N1OpMaV0FmY/
	 4sg4Hif72Ud0HrbRMMtLlNDt78P1Cf/yUQMMck+XAbeNm8NywUWwQGgTiOYLt+9vJB
	 NpagraTM73ihA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Aug 2023 23:16:08 +0300
Message-Id: <CUU8UN9WOC56.1XCQH80U6OXYC@suppilovahvero>
Cc: <linux-integrity@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Richard Cochran" <richardcochran@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>, "Daniel Sneddon" <daniel.sneddon@linux.intel.com>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH] tpm_tis: Revert "tpm_tis: Disable interrupts on
 ThinkPad T490s"
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230814164054.64280-1-jarkko@kernel.org>
 <enaeow6numvzp74rrwpdqhjqs635ofqttj7o7gdoqfrsgbhihi@eb7ueum3r5w5>
In-Reply-To: <enaeow6numvzp74rrwpdqhjqs635ofqttj7o7gdoqfrsgbhihi@eb7ueum3r5w5>

On Tue Aug 15, 2023 at 2:13 AM EEST, Jerry Snitselaar wrote:
> On Mon, Aug 14, 2023 at 07:40:53PM +0300, Jarkko Sakkinen wrote:
> > Since for MMIO driver using FIFO registers, also known as tpm_tis, the
> > default (and tbh recommended) behaviour is now the polling mode, the
> > "tristate" workaround is no longer for benefit.
> >=20
> > If someone wants to explicitly enable IRQs for a TPM chip that should b=
e
> > without question allowed. It could very well be a piece hardware in the
> > existing deny list because of e.g. firmware update or something similar=
.
> >=20
> > While at it, document the module parameter, as this was not done in 200=
6
> > when it first appeared in the mainline.
> >=20
> > Link: https://lore.kernel.org/linux-integrity/20201015214430.17937-1-js=
nitsel@redhat.com/
> > Link: https://lore.kernel.org/all/1145393776.4829.19.camel@localhost.lo=
caldomain/
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> I was just typing an email to say that it looks like 6aaf663ee04a ("tpm_t=
is: Opt-in interrupts") will require
> updating tpm_tis_disable_irq(), but you are already dealing with it. :)
>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks!

BR, Jarkko

