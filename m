Return-Path: <netdev+bounces-239347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC10C670B3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id BB8E323F4B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9C63254BE;
	Tue, 18 Nov 2025 02:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIcLWU8R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138E2D0631
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433851; cv=none; b=rLXM3pwtl9vpbq3ldK8dUuXrs/+3fPIq/KldOpzzyVAT3MZ8lhDFttdkkyr+lpTN0fgOc2fp1hAgHIZWU+IPtZNJyM3QVQDJDK/e1zcANSP80tLVIiAK6aFFoLavxhbDaNCjYSd6tL7o4jKDlvxVT9MlRiu6mVoPXX9d5zCuG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433851; c=relaxed/simple;
	bh=T2i5EXg5pUjBgOCmxY1mdqgGaYKX/Wog3/pySxcqeyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naIJP7qA5vD/mi13V4SYMeCYTUg27GqiY+9m/J1KJ4ZtW1CpqJgaFiDts3VbiabkdEkA3klf0uaarSO0010kUP2JyXL49sX2MohlJmAAosz5/THnaxMenwgUHp5Pc2s5fX066GbACosweomAByjzE17Ig3fNxITX60cB8/X0C4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIcLWU8R; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso1022577b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763433848; x=1764038648; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M042loYaXFofILJwlE8k6U1p0bY4FWeWgekh3e1FjWg=;
        b=EIcLWU8RUxMdpLCDdVnVimrEH6UNhCC4XeMD+UO+UCinN5bowTLy9FUj/rIQXK827t
         TH/q93tcSfP3tA9ZI69nmnWl38vvZSmlSazzwip4/7v8qngwy38NN0NWoE6qo8NXFyai
         OU2K4t2UAEGFDLNdTBMNUxZTI5me0gvq1ACjsT9uJYb4F2jbLP6okeT4WNA6XrZfGAXp
         I+uwvi5+dHD+/MJ0TvgSkvn50C05YdWmYaSwS+CfXL5KMzYsCWBymVGVlcr2qC7ThHKh
         SS/hkviqPcBkHB6CCpZunlGJNyZ7W7aS6fvJ59TEQNo3K24MYUeKePRxns07XQmt6LNr
         +pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763433848; x=1764038648;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M042loYaXFofILJwlE8k6U1p0bY4FWeWgekh3e1FjWg=;
        b=UIQi/VrggGbfeQXvEOmLq/b0eiPH7BPSRNsGiZRKwCx0rI3K4a6ucA9BXyZcxTdNB5
         YwP7a+2daLLTlxoI7V49ZhCUjJggOxcZ1z+kBZ99OgJKhAYawXBetY1nBwOZqUMu07Bc
         CQeqgW+23x4a1hsM7TwBSpJd1ZZg4bqSGXOlmzp71E48uOT6+Mlv0IhKCrVhupAReGdE
         ks7Mmr0mYY2XG8vFpVEkD3/+Gym7ZO50+nE3MrFML48QaKeA0OHvL3w3MvJgUOTAGjfJ
         3JSE0lJ1qvlgFStJr1LXTHR7SKx5AC1xRZRvxAGaG8I1ApbtJm28dfy5vyJf+znFeRVk
         I+KQ==
X-Gm-Message-State: AOJu0YzfIB1aYGlP6U83HnmzpysBEpWfxJJseGtJviTqZ6kP0fKCSZsY
	eJ2uoLygsw5qbplz6My32wfMKD9J1uOCwaQVnA59WAgn1hu9NYWbBIcj
X-Gm-Gg: ASbGncuUWo3I2/qZydpMcqvp8rePbwIxfPwYZElYyuPxFR3Aj3l/ANf/cD0TUd9Tafm
	yv24oeiWVwSNTCfbEtcUM93LtbpYGNUeZIvrCeE9CbaF4TANAanesd1jfsR8nQpgqB2XhQkD5kj
	HkAZ0dFpp0fCcaNSX9NiXhVMpJONv/jfxaV/2UcUTWyeI+1JSL9Ttd3+b59DgJPXvOJt5bLsJ4L
	X8X+1tvNEiJEAS5dT/K2CouyRac2rDZpkNPOPi6TMuOgQaFe8rguh9BzAr5r43Omn13hp2bcoGq
	9m1eiFxjUFqOw2tKHPapqA/ddW9qIG9lllyMtoOm0XJnJbWipwBBS38d0SF/cH7Wx45FF+XjPFG
	KxXDlCWl2tdQyfDNaZZtJ8oOnn3wHyGB1XqSuIBh1kAOZz76oMsHa/h0EJefrATcVAH3I3upds3
	8XU2FCfbdpWXFiiX5pp3NY6LUiHw==
X-Google-Smtp-Source: AGHT+IEivVNZyA22uPoRtfAnjtNUxnW+RumQnM0IoFu3zGcPqjo4vlWQMadtkzGLGpB5xWdVqzga0w==
X-Received: by 2002:a05:6a20:2588:b0:358:dc7d:a2be with SMTP id adf61e73a8af0-35ba007e759mr17867249637.17.1763433848003;
        Mon, 17 Nov 2025 18:44:08 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db21e76sm13766237a12.7.2025.11.17.18.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:44:07 -0800 (PST)
Date: Tue, 18 Nov 2025 02:43:59 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv5 net-next 3/3] tools: ynl: add YNL test framework
Message-ID: <aRvdb65MyVc39nm6@fedora>
References: <20251117024457.3034-1-liuhangbin@gmail.com>
 <20251117024457.3034-4-liuhangbin@gmail.com>
 <b3041d17-8191-4039-a307-d7b5fb3ea864@kernel.org>
 <aRvIh-Hs6WjPiwdV@fedora>
 <e7aba5b3-d402-4a09-9656-1b96be6efa84@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7aba5b3-d402-4a09-9656-1b96be6efa84@kernel.org>

On Tue, Nov 18, 2025 at 03:21:35AM +0100, Matthieu Baerts wrote:
> 18 Nov 2025 02:15:08 Hangbin Liu <liuhangbin@gmail.com>:
> 
> > On Mon, Nov 17, 2025 at 11:59:32AM +0100, Matthieu Baerts wrote:
> >> I just have one question below, but that's not blocking.
> >>
> >> (...)
> >>
> >>> diff --git a/tools/net/ynl/tests/test_ynl_cli.sh b/tools/net/ynl/tests/test_ynl_cli.sh
> >>> new file mode 100755
> >>> index 000000000000..cccab336e9a6
> >>> --- /dev/null
> >>> +++ b/tools/net/ynl/tests/test_ynl_cli.sh
> >>> @@ -0,0 +1,327 @@
> >>> +#!/bin/bash
> >>> +# SPDX-License-Identifier: GPL-2.0
> >>> +# Test YNL CLI functionality
> >>> +
> >>> +# Load KTAP test helpers
> >>> +KSELFTEST_KTAP_HELPERS="$(dirname "$(realpath "$0")")/../../../testing/selftests/kselftest/ktap_helpers.sh"
> >>> +# shellcheck source=/dev/null
> >>
> >> Out of curiosity, why did you put source=/dev/null? It is equivalent to
> >> "disable=SC1090" and there is no comment explaining why: was it not OK
> >> to use this?
> >>
> >>   shellcheck source=../../../testing/selftests/kselftest/ktap_helpers.sh
> >>
> >
> > I got the following warning with it
> >
> > In test_ynl_cli.sh line 8:
> > source "$KSELFTEST_KTAP_HELPERS"
> >        ^-----------------------^ SC1091 (info): Not following: ../../../testing/selftests/kselftest/ktap_helpers.sh was not specified as input (see shellcheck -x).
> 
> How did you execute shellcheck?
> 
> If I'm not mistaken, you are supposed to execute it from the same directory, and with -x:
> 
>   cd "$(dirname "${script}")"
>   shellcheck -x "$(basename "${script}")"

Ah, I forgot to add the "-x" option... I will fix the comment in future test
case update.

Thanks
Hangbin

