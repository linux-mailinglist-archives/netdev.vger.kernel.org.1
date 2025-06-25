Return-Path: <netdev+bounces-201246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7811FAE8959
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E9918986BC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5F726B0BC;
	Wed, 25 Jun 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4YwGQ1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC917A318;
	Wed, 25 Jun 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867940; cv=none; b=OGFy+ysKLwFWI4xu5uVFya89xM/Xw9wLSOkbQaUQDmLWu89bzntwpHcqnBp27pbReinnWzeYitccLSZQK3RrvJGuA/KFtqHXnbVNG/R827hxIKAfao8v9ARtewNchwmKFR40WYTueTHApxdQcX0pwWWMRUvzBDlv1O0FsT1YVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867940; c=relaxed/simple;
	bh=yG3+snXxvnjzdEUf5t52YKU1CQdD0bOMeG6Sa8cZzPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfyIW55M+tAnk6Ue/mmLRQUnMMv77RUY5xFxbsN6h2qvz7/CGeEW9KB/NrUFe9xH731KrEWgg6ZXqLqdGKLfQ80rW+k69jNhRE3k4+FbSxK5Y8otS49Y/9Id5tFEsp7QaquWadrAHysHyMxE5XG3nYYroBmpG6+M18fwneni+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4YwGQ1X; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso5700241f8f.1;
        Wed, 25 Jun 2025 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867936; x=1751472736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSKrbExAoGwvgE3h5wZvMDKnEiBJEg6qC3SK4TyWodQ=;
        b=b4YwGQ1XTbZtbGBLhhbjqfpTr6lEsuhBSz8ItYLdHEjDEYt6nK5LMI4Wj23Ud4EXu/
         LUDSghdDk1clZ+xPojJVdXRnJ0tTfWWeOOYSqBGSMM+ryNy9T9atB5SO17lVbKyg8Jzw
         dxIH0XAHKZIr25kiRdDkaJ0NuTlkDZq2C7GagtrKItkO1F8Ak8mZAkyqVx/eEdwUfl69
         FgVEiiOZRA1cn1Xy5Pyh/wlXd1DoWfI6/J5AzcxsKciFFAP4yQcJWm+d8S1sWFQoB8Hc
         i0cEY6V+JeQ1LQkTE0cMfcMCkCIfrzV9tMUTzu8LTpl/B50PGRbFdrdgiqI42GHw3yx2
         9fDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867936; x=1751472736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSKrbExAoGwvgE3h5wZvMDKnEiBJEg6qC3SK4TyWodQ=;
        b=I0ZRz+e5NWxn7HqS0r1TR9Wu5D6lzezutWz5SOFfNC0dFVn39UtFi97f+AvrfmiFf9
         +7z4JFxEm0ILOXIj/NEq1pFHDPsIZBI04b4JtjIAVY/SbvKrjm67Ydk7Lv84U9GVyWik
         OJsC7dYvPb0F5yjQ0bF/D40uShL3HBAv7V0ZEPzuIH13NSN3lYWMhUmFxsF5yZVQCii6
         ZTXmsXdzCu/RQ5m4k6AtOewG+HzAbNy/piLOf9YU1gG9gE1EtJd6rl4U1eZyGYy2tyO3
         sAm1ycjwpI8tHB8Vts3ylFJDWDPdBh8Ne+409Fj1QFRML7X4M8dDDjv51ZDubT/Be3my
         E4cg==
X-Forwarded-Encrypted: i=1; AJvYcCUh2DsYgyYFMoTlPSWzvUxlVS2gOheoVubGCJl+IRfPX8U9eEwCTCYxPq4fxYPZ+ODaNhJ9CMWs@vger.kernel.org, AJvYcCWt33/bnUi+QiRMEXISFCwI+WG3quKdEDhVSZL+4Jfzc/g0hTbIxA3TmIANOhQOzq4yJLhvGhBZe7SAjeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzkAg99Wln3zxF9xu3K+SGFtFM0EaobPmqZ3ZJxRNtQzPTR0+
	Tgb70HB7sx5t4S/CwFplpgEqeNydtMoYvfBuptJHKCqos2BM9wKikEXo
X-Gm-Gg: ASbGncv2138ISWs0oKn5fP9OVGd4zrfDuTSdJLatujUqLmLIe0pDZ0itKoUDRLd4CRv
	hf4hX5UG60J//xMF26U1G6U0x95Vsj/2nNNcnFbQDpm82XN7mc58Urdm3KL8cOnq5n944Tve1Lr
	k3hoGzg43BJa2v2iDT60p9vOKqZ/3+l/Di/w3m1jsAExevEtJNQIcnoH9/A4EW1ijYMWicOHlP0
	S25Nu/ELHHA83Iz0BUz6lVVgadOZb0O0CS4rDChp5D453iOuhSXrI1JinKO23y2ai+O8UiXI3Tb
	R2zgiXyK9YX/4RCi7qCN1W7FwrrhXtkNePtTHlA+x8Ukf0r0iuyJnoHmWXN7NIy65Cxdjx53YlH
	jPoqwoUvOp1vguncyJyMa6yOO
X-Google-Smtp-Source: AGHT+IH4lJNGPB4RyhVXajT2id0Stq+E++QsUs8QRfnl4dQOmic7Xc9jN2I06E6CUU2T/tXSzcE8NQ==
X-Received: by 2002:a5d:5f91:0:b0:3a5:2465:c0a4 with SMTP id ffacd0b85a97d-3a6ed5db111mr2968525f8f.20.1750867935704;
        Wed, 25 Jun 2025 09:12:15 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8114774sm5071397f8f.94.2025.06.25.09.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:12:15 -0700 (PDT)
Date: Wed, 25 Jun 2025 17:12:14 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Jacek Kowalski <jacek@jacekk.info>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] igc: drop checksum constant cast to u16 in
 comparisons
Message-ID: <20250625171214.5d752668@pumpkin>
In-Reply-To: <20250625122239.GE1562@horms.kernel.org>
References: <46b2b70d-bf53-4b0a-a9f3-dfd8493295b9@jacekk.info>
	<5589e73f-2f18-4c08-8d10-0498555dd6be@jacekk.info>
	<20250625122239.GE1562@horms.kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 13:22:39 +0100
Simon Horman <horms@kernel.org> wrote:

> On Tue, Jun 24, 2025 at 09:31:08PM +0200, Jacek Kowalski wrote:
> > Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> > Suggested-by: Simon Horman <horms@kernel.org>
> > ---
> >  drivers/net/ethernet/intel/igc/igc_nvm.c | 2 +-  
> 
> I think we should add this:
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c b/drivers/net/ethernet/intel/igc/igc_nvm.c
> index c4fb35071636..a47b8d39238c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_nvm.c
> +++ b/drivers/net/ethernet/intel/igc/igc_nvm.c
> @@ -155,7 +155,7 @@ s32 igc_update_nvm_checksum(struct igc_hw *hw)
>  		}
>  		checksum += nvm_data;
>  	}
> -	checksum = (u16)NVM_SUM - checksum;
> +	checksum = NVM_SUM - checksum;

Indeed - especially as the '-' code is really:
	checksum = (int)(u16)NVM_SUM - checksum;

  David


>  	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
>  	if (ret_val)
>  		hw_dbg("NVM Write Error while updating checksum.\n");
> 


