Return-Path: <netdev+bounces-115409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89510946422
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9481C21CDE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8B6CDBA;
	Fri,  2 Aug 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wtjd3rcY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD611ABED6
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722628339; cv=none; b=sDbs8o4+aDRrRW/wpsV5KvaJnQGCX3sMOTw5Gia6Vbg4gMK5oenSWQGyY9DvElGz5rBZp62Iz5wv6BXcuNO1Il5drhDlKpII9aBmOCpO/lzed4X00vzDVsoPiokxH9jguwn56HpHIhmed1j9BRL03x/S8mETrVbmPi2bPNKnGbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722628339; c=relaxed/simple;
	bh=vKxVRXeug4FRLwqILp80hhJmDOr+dFzd4iEthpeQkOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1J71kn7fdAkLWTKCifrvsVxmAPlcBpBoTwyMlqKRMH1s2TaICdJf1YQMO0SuTShpVQgAsiMmfq5AHFjO+GyNPBt5hyHfFuV9iU3MHPhf7F65byahCI9wN6aJWXh63HeCc4ix/8FYdjYAcwn5rNlgPx9UdeS4o9f0aG3xyocTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wtjd3rcY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722628336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SCsjNevSFiet/Sgy15L1fkfMNQj95z+afVS4JRle7eo=;
	b=Wtjd3rcY3l8+x7dbaUvJEAnqc3Q+SlkzREUWm+19Fm5QVxg6wyH6Zl3x0Ee5HG4QEoqXd2
	m9l1afgZ04miGGDS55DdtrSUv8CN2PtOx7j77lhgiKbbE1ksMJXSMRgRUQrg43Cc0IPNq2
	nLrBOmEvRc3WtYso+jqHDDd4zgTtYVA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-OMq1WeHIMfShtGy5L6cF0A-1; Fri, 02 Aug 2024 15:52:13 -0400
X-MC-Unique: OMq1WeHIMfShtGy5L6cF0A-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4501f170533so84789361cf.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 12:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722628333; x=1723233133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCsjNevSFiet/Sgy15L1fkfMNQj95z+afVS4JRle7eo=;
        b=EJTbMiqSY5tsH3ikUFdwoipu2uSaxY1EWhw+KZn7DG6jLw0vOHZdU/oAnYR45e2plc
         QJ29aKo/333aebR8SaCVKE+zsgvaISeRNlT4HG5KAntI5+nNg3NvLmviCZA0nepuH7FK
         JC+esQv9cROD61UCONPvN9LripakkzIAH6ckVGwbd5NfRLLTydjUtXnH1uI2npEAOdlj
         SeHNOUqUB4NGNTzlt+YkPxBrF3iaXtgqZN5KayzBFUR+EoUlp5QHrJvkRZgruOJYFvZz
         bYR4l2/IP3WVAIgQI3kN0+ZkLyCqq1fwbK3/5uViLQO5EaMQ7dsmk4Uv7BZK+K+c385O
         jmQA==
X-Forwarded-Encrypted: i=1; AJvYcCWAf/va9S+YYVRrvI/tHptLiM7QyR0aIjVc9c7Ib3+fsvi/mIoUeZYsLUpsmmhnGnX/Uuo5BhkVA8vG7q4I+u8EPFEJZ2IJ
X-Gm-Message-State: AOJu0YzY9/47pLbifhvMBP1omYTngRDMcbzVQRbEtBhnxUENFtrIqGs9
	1LsMIvfYsdcm0LdBKXLQUAwdTNtJVJ5hSvskc2TO3vzN94ANOYyFf805jBsiLQWU+WDMiCt+5dk
	w80QtDs4iEzzhOjRDTYhUN+2JEQkO/Biue14FTk/bd4VR7pgJjLyYKg==
X-Received: by 2002:ac8:5709:0:b0:446:3c7a:3689 with SMTP id d75a77b69052e-4518929e48cmr45098701cf.43.1722628333183;
        Fri, 02 Aug 2024 12:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQFUukQHhlMedRIzlWH4c8TXYeBXJnK/PmOlc0utWYdYqCu+TF87zFhfKYBnIx3afbcZp6gQ==
X-Received: by 2002:ac8:5709:0:b0:446:3c7a:3689 with SMTP id d75a77b69052e-4518929e48cmr45098561cf.43.1722628332832;
        Fri, 02 Aug 2024 12:52:12 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a753eafsm9698351cf.62.2024.08.02.12.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:52:12 -0700 (PDT)
Date: Fri, 2 Aug 2024 14:52:10 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC v3 0/14] net: stmmac: convert stmmac "pcs" to phylink
Message-ID: <pjq4xwrfgbz7qix5okt7wbqccjcwojaurh6jp2myou53s5ao4h@4rizzerirz2x>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>

On Fri, Aug 02, 2024 at 11:45:21AM GMT, Russell King (Oracle) wrote:
> Hi,
> 
> This is version 3 of the series switching stmmac to use phylink PCS
> isntead of going behind phylink's back.
> 
> Changes since version 2:
> - Adopted some of Serge's feedback.
> - New patch: adding ethqos_pcs_set_inband() for qcom-ethqos so we
>   have one place to modify for AN control rather than many.
> - New patch: pass the stmmac_priv structure into the pcs_set_ane()
>   method.
> - New patch: remove pcs_get_adv_lp() early, as this is only for TBI
>   and RTBI, support for which we dropped in an already merged patch.
> - Provide stmmac_pcs structure to encapsulate the pointer to
>   stmmac_priv, PCS MMIO address pointer and phylink_pcs structure.
> - Restructure dwmac_pcs_config() so we can eventually share code
>   with dwmac_ctrl_ane().
> - New patch: move dwmac_ctrl_ane() into stmmac_pcs.c, and share code.
> - New patch: pass the stmmac_pcs structure into dwmac_pcs_isr().
> - New patch: similar to Serge's patch, rename the PCS registers, but
>   use STMMAC_PCS_ as the prefix rather than just PCS_ which is too
>   generic.
> - New patch: incorporate "net: stmmac: Activate Inband/PCS flag
>   based on the selected iface" from Serge.
> 
> On the subject of whether we should have two PCS instances, I
> experimented with that and have now decided against it. Instead,
> dwmac_pcs_config() now tests whether we need to fiddle with the
> PCS control register or not.
> 
> Note that I prefer not to have multiple layers of indirection, but
> instead prefer a library-style approach, which is why I haven't
> turned the PCS support into something that's self contained with
> a method in the MAC driver to grab the RGSMII status.
> 

Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride

Note, I also tested with setting sa8775p-ride to:

    managed = "in-band-status";

and noticed no issues either when signalling was done in-band. Just
highlighting that since there's some comments referencing the lack of
in-band signalling with dwmac-qcom-ethqos usage in the series, but it
seems that's ok in either case.

I know there's the "sa8775p-ride-r3.dts" that was recently added,
running with "OCSGMII" (hacked up 2.5GHz SGMII IIUC), I can't test that
since I don't have that hardware. I think some of the remaining
interesting bits in the dwmac-qcom-ethqos driver are to handle that
(like the usage of ethqos_pcs_set_inband).

Thanks,
Andrew


