Return-Path: <netdev+bounces-111725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F076A9324A9
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28C3282A61
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D761990B2;
	Tue, 16 Jul 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFqYks1F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8CA198E88
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128382; cv=none; b=QcMSMidkRgwz2dIxOL3R5coI20uTar5cdBE/s5hxM/X8txZw5fGhb/8sE45LEM2WOw3FRi4nzf7pCoyU/NWr89G3UVZKnk7Eos9wzkqXwwJMNROOD3NBQ0iAVbehQONYU3nwFx6MdlpGq4kKTTx3f8VZbIEdU90tBvrmVv9afvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128382; c=relaxed/simple;
	bh=Npyk8yTFFIp3zu60cJGVp6aA2D+oqrywC7FU3CijOAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpVNVhXDMnxU3gW8ydm18PE1HpoAQsuLdwvPVgtlxHfq12xsU1irZcPTuYfvuU250jN3Yz0mj+pjthAGX4Ae0k7SjpBeoAlstNqWbh3tSrqrwhxAVv+RXnoubuNuIS5NMqYn/ncM7xw4fNtNo4MLHwXexcUpFQTpJ+fRDcZ7F7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UFqYks1F; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e98087e32so6412919e87.2
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 04:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721128378; x=1721733178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkRwuDFICXCFOrI/2I8SRM97q+8MIDN5II0awTzIkIA=;
        b=UFqYks1FUQj1fkWtSQONxgEwcl+o5btCtEqDcCrVT9OxqiHB9vYmhNm1+w7/X4+VFH
         Q9qiZiDhyUvnxE1bLmtmcUACwFMWspkXahEVywXfGHMy/FedYBFK8NjjV91fUU/z/RHF
         lgFmDrUqZjYRIFeA8JJ57TaCkFrXfNr711ynsBu0aawhbENZ9a9TIHt31O5yVfCEeTED
         /RJrjLCLs1VPO855WiAi7XY0fkMIzmbI/J9gJyGAXtiz5kW+3t5oS+rpy0YHW7f7vskh
         SYLrCG9cYkuSNo1Xj38ZvkiOJDfEFcxq1XENPmmuBtgwWgxSpH+kn2UKY3YPeaLLVMR1
         PfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721128378; x=1721733178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkRwuDFICXCFOrI/2I8SRM97q+8MIDN5II0awTzIkIA=;
        b=ogjR5ObLLR0SYNWfu6m0ttb1xXr5Z8GwdRTCcwO2oy6nrzK86wSNEQSs36B5tOaVtn
         Tat6vrNUhW387gGq+t3k21x8QGcfP+JtOBg3Wve/svOHN3jOYTOqYRh7rKmtjHaPEI6M
         pNzc0ITdvhyKWxehmxcjw/aJ22t3RQgC8WqyrhejtLS4IkS8tlJU9UrIo2chb/kN8dWk
         jcYxpUUkxgsmzpsx2Q8p8nijSuO9+XIux6IWS3EYRf8Y/l355WPD2eAoS/UWWFJBR7jA
         WHBrLWHKZUIUwbNYS9w/A+kXCnLYDQFRyJsA2iSKGLq+isj+Sde8IebOErz+StMqytzK
         NwhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeJunqciGsPBOFFc1WzRBUCqYKicSnbu9WdgZNYMXWFLwzKmFhLyJ8myZk1BFJ8uQFJEkgJ47IFS/BSPoJeM2wmPx5bSOJ
X-Gm-Message-State: AOJu0Yystdv2mF+Jj7VlqXMAPhKlzyeifOTmw8phjYsPy+1dVcWxaCUH
	9teFys2YXhZ1gY9awoYv1qnfTZfpkvJ8lXEolelvgydbdsoGOmcxYxkIaFmgJhM=
X-Google-Smtp-Source: AGHT+IG35l+B1/YBwglx16llaqYjEWDCga2Oe9hUaLufPC7j7EzfiIml0NpEIJWCt7t15bPWQxNWIg==
X-Received: by 2002:a05:6512:138a:b0:52e:7a8c:35a0 with SMTP id 2adb3069b0e04-52edef0e8edmr1040257e87.7.1721128378321;
        Tue, 16 Jul 2024 04:12:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed25398basm1111790e87.285.2024.07.16.04.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:12:57 -0700 (PDT)
Date: Tue, 16 Jul 2024 14:12:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Patrick Wildt <patrick@blueri.se>
Cc: Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Steev Klimaszewski <steev@kali.org>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100-yoga: add wifi
 calibration variant
Message-ID: <56zweixkjz2oqvmmxxgd3zoc2jf4us4mmhutjtjvejsurtycwh@fv24arxg2eqr>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
 <ZpV7OeGNIGGpqNC0@windev.fritz.box>
 <cisap4ctuolfrs6hjqxz45fqtckcy6uhjzma2shcxkso73jvoh@jj7l4bgftoir>
 <ZpWbUjHna1cE5zHW@mone.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpWbUjHna1cE5zHW@mone.local>

On Tue, Jul 16, 2024 at 12:01:28AM GMT, Patrick Wildt wrote:
> Am Tue, Jul 16, 2024 at 12:51:53AM +0300 schrieb Dmitry Baryshkov:
> > On Mon, Jul 15, 2024 at 09:40:41PM GMT, Patrick Wildt wrote:
> > > Describe the bus topology for PCIe domain 4 and add the ath12k
> > > calibration variant so that the board file (calibration data) can be
> > > loaded.
> > > 
> > > Signed-off-by: Patrick Wildt <patrick@blueri.se>
> > > ---
> > >  .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts      |  9 +++++++++
> > >  arch/arm64/boot/dts/qcom/x1e80100.dtsi                 | 10 ++++++++++
> > >  2 files changed, 19 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> > > index fbff558f5b07..f569f0fbd1fc 100644
> > > --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> > > +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> > > @@ -635,6 +635,15 @@ &pcie4_phy {
> > >  	status = "okay";
> > >  };
> > >  
> > > +&pcie4_port0 {
> > > +	wifi@0 {
> > > +		compatible = "pci17cb,1107";
> > > +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> > > +
> > > +		qcom,ath12k-calibration-variant = "LES790";
> > 
> > It doesn't look like it follows the rest of the calibration variants.
> > 
> > Something like "Lenovo_Y7x" or "Lenovo_Yoga7x" sounds more logical.
> 
> This is what's both in the DSDT
> 
>   Device (WLN)
>   {
>     [...]
>     Name (BDFE, "BDF_LES790")
> 
> and kvalo's board-2.bin for this machine:
> 
>   $ strings board-2.bin | grep LES
>   bus=pci,vendor=17cb,device=1107,subsystem-vendor=17aa,subsystem-device=e0e9,qmi-chip-id=2,qmi-board-id=255,variant=LES790
> 
> I don't think we can hand-pick these strings, they come from whoever
> decided upon them and fed them into ACPI tables and QC's binaries.

Ack, if Kalle has already selected this string, we can't argue.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

