Return-Path: <netdev+bounces-115005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E86944E1E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14453B25F71
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A777B1A4861;
	Thu,  1 Aug 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="VW3UvCf9"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4791A4F31;
	Thu,  1 Aug 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522842; cv=none; b=SHTBeLEa2eN1qsuNn6olMfxiR9MVayxX8pgiYdb/8r76F1I1M3dtCCiHQCIloQYw1vy8aBPgYawNcxf5Ngj5xK8jffcSRsbNtErugarDU+NUV5SqfrmtYjt5H5kepcdG9hGxZMIvPWPmdsHZiOyh7De35k9tLyFp4xHyJ3R8m9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522842; c=relaxed/simple;
	bh=EtgsdD/tcXlI7IywHG7B6PRD/S4LEQyLuNotAoyg6r8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JGO2CSVludPzDM+7PRNnNxcr2LDZ19/4kqYQdzrwSnhA0uIeGIjBl6gJCHKhebo7xtuLOmwo1pfGKxutW1iCB3RqDt7UCL0XT+9DrnsCVzSuKqHopNM6qoeVSw2mmbguyB4CcHiyigMSrO6qKO9+gYXdKiRIRmNsOLXE/ztZIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=VW3UvCf9; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 471EXKTV1466366
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 15:33:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1722522800; bh=Y5HqFnY3u2zASuOrSmY/8h+acG0+jNsTNe/DPcSw8xg=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=VW3UvCf9p2R5DB6AwCQq3qcItIs36Mn8ZxMfw6U1msRcXPsolur2UesvWeJ1hDegw
	 ImylfR4FSDSBXsRVj6hLZfP+YNuftDTYAcdLlGqZsp5W3D3XXwJiXqMuB8eb7tGh5M
	 fohZxPD+ZlXQBv6EyWe+2BBhjRfasJbMsymWILTw=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 471EXKBT374820
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 16:33:20 +0200
Received: (nullmailer pid 559368 invoked by uid 1000);
	Thu, 01 Aug 2024 14:33:20 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: usb: qmi_wwan: fix memory leak for not ip
 packets
Organization: m
References: <20240801135512.296897-1-dnlplm@gmail.com>
Date: Thu, 01 Aug 2024 16:33:20 +0200
In-Reply-To: <20240801135512.296897-1-dnlplm@gmail.com> (Daniele Palmas's
	message of "Thu, 1 Aug 2024 15:55:12 +0200")
Message-ID: <87ttg4gvnz.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.5 at canardo
X-Virus-Status: Clean

Daniele Palmas <dnlplm@gmail.com> writes:

> Free the unused skb when not ip packets arrive.
>
> Fixes: c6adf77953bc ("net: usb: qmi_wwan: add qmap mux protocol support")
> Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
> ---
>  drivers/net/usb/qmi_wwan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index 386d62769ded..cfda32047cff 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -201,6 +201,7 @@ static int qmimux_rx_fixup(struct usbnet *dev, struct=
 sk_buff *skb)
>  			break;
>  		default:
>  			/* not ip - do not know what to do */
> +			kfree_skb(skbn);
>  			goto skip;
>  		}


Makes sense.

Acked-by: Bj=C3=B8rn Mork <bjorn@mork.no>

