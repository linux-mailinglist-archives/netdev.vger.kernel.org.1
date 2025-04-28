Return-Path: <netdev+bounces-186493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE2EA9F6E9
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327F2188997A
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04872820B3;
	Mon, 28 Apr 2025 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qA13AxQE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E727A909
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860268; cv=none; b=inJRdzwuXDa6LtS3GZ5aBreaZkHj6ANIK5CdLSX6MFQq18/hTLuydV01qWf5gtWqcPd0QW/QvqtAUSzSeRf7Sqc2C473joufqN/fNaJ4LFL1kk09it0xBPfpOVW/Bd+2KlC9jqLCrMCrJwbwjYjgY013M94GkZrGrduCaA5zxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860268; c=relaxed/simple;
	bh=nSeNXvDnaOqFKsAV/RsdD+6WADtL+fqUWlCm0x9+mqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+b/9yTj+Kq8iO/sRg//tN7xrHg2RoS7Xdb+AaFCWsRwTRD4Taq30+ZFT7eYYdqVwtMtLcRfUtHU0ApKj2miibbgC1V/A7pfzjOQad7X47x7Yi/xrB6uoTnN+iKZZC0SW92QatoznBI+/6EIibtEPTfcLCXFO5f9ymzRRawiYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qA13AxQE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2260c91576aso43352525ad.3
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745860266; x=1746465066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Q5LkUZPUlzr/ahp/6kHXMAoiCYPR6xYVis2GwACS9k=;
        b=qA13AxQE1N0mgwKGeyNnlIxcLOf6SO8xmQc7ui3NTVuDMR5VhJeiCsnYQcYYRmK/3M
         NVhxREWV56CxfDqWe/F/rznTwo9rgFxLva1XJPJf6+TIuh/zZUAL6naP7+tOMdVq69pT
         0KJ3KKfvxABPtySWi1Vpxi/eSVDcYNN2NuuEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745860266; x=1746465066;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q5LkUZPUlzr/ahp/6kHXMAoiCYPR6xYVis2GwACS9k=;
        b=uAOYTVAMdI0600EPDSKlQbZ5lI1UGFUCj6zaQv9VyhqgdHRDbrECsbcz/fOU9TGcVP
         AWs0LK/FCw7yCtU5twTAZ6jXIDl+gRn7yRldTLcUB0WJcuFjctuPpbHgTT8N/wwZ5kvr
         C5Wjdcn9SnDMGE6yeDtN09wg6XMvj1uLXzG729mJwttlRP57aATR869BPS/YBZpMmJgd
         f0dlEEixa3iviKMuRqeTZvQWHbzbc7GY/KEmJBCSpNgab82GcNq5TMikuexGMILer9Nh
         v/PmfJEbYRoAdISyv/fNwN8AtF34T9TRnC+HaW1XbKk6w8ac98rgSCzvNxT3gjw3ycTm
         wCXw==
X-Gm-Message-State: AOJu0Yzp6PnQ+opb1xHXp5wZt5+OHJOBNuXG0UtS2+vyge4Qlabd6/Q7
	d4OjC2ecSpdMch208dYl2EO5qti8wWUmV6ADF3T5kxPekFR8rNy2Kq1O9vAJ5eE=
X-Gm-Gg: ASbGnctOy7eeP0jBBIKBUVotJ5P1mIzm1T0dQa/2EVd+jzbPDCwd9fTs9l6BPlktepq
	kkKYoBkAiq6lcK1bcLi+PxYhvUgc7RrwC6QFxcOtL6l1xpiJm/Up0Vg9S9EEyO+/zjZ+zXceroD
	qhp7r2+vWo0A9wn3EonhymzzQsayf14vNnyCbswjVTiArSLGPxPF91ukNdIJG9ZTdAmun64O4JQ
	SAvVB0ulGueAcPtEZa+ReS3dzajZcews4ZACwMIPaDi6sYSkF4RKdTtv6w6sP9VvRJNYIWPBOuF
	3WOkavC4QukS9CxmaSI1GTuIZgJDXZ5WD8jK84fWt4l1EIZGNnstvk/k4ZZg8mGHnXAYp43mxI9
	i9t53ryHNy+tlxA1Xog==
X-Google-Smtp-Source: AGHT+IF5ZqKP0TLpXAgeJ4Za5tXT5w2hTZlm8Mftf8DcyT+dfZT72HdhVbHpvchcvgBLqvplKVGKjg==
X-Received: by 2002:a17:902:dcd4:b0:22d:e458:96a5 with SMTP id d9443c01a7336-22de45897f3mr15051195ad.38.1745860266268;
        Mon, 28 Apr 2025 10:11:06 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22dc60bd15fsm53342275ad.15.2025.04.28.10.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 10:11:05 -0700 (PDT)
Date: Mon, 28 Apr 2025 10:11:03 -0700
From: Joe Damato <jdamato@fastly.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/2] io_uring/zcrx: selftests: use rand_port()
Message-ID: <aA-2pwRo4pBjg7rm@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250426195525.1906774-1-dw@davidwei.uk>
 <20250426195525.1906774-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426195525.1906774-2-dw@davidwei.uk>

On Sat, Apr 26, 2025 at 12:55:24PM -0700, David Wei wrote:
> Use rand_port() and stop hard coding port 9999.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  .../selftests/drivers/net/hw/iou-zcrx.py      | 48 ++++++++++++-------
>  1 file changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> index c2977871ddaf..3962bf002ab6 100755
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> @@ -5,7 +5,7 @@ import re
>  from os import path
>  from lib.py import ksft_run, ksft_exit
>  from lib.py import NetDrvEpEnv
> -from lib.py import bkg, cmd, defer, ethtool, wait_port_listen
> +from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen
>  
>  
>  def _get_current_settings(cfg):
> @@ -28,14 +28,14 @@ def _create_rss_ctx(cfg, chans):
>      return (ctx_id, defer(ethtool, f"-X {cfg.ifname} delete context {ctx_id}", host=cfg.remote))
>  
>  
> -def _set_flow_rule(cfg, chan):
> -    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port 9999 action {chan}", host=cfg.remote).stdout
> +def _set_flow_rule(cfg, port, chan):
> +    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} action {chan}", host=cfg.remote).stdout
>      values = re.search(r'ID (\d+)', output).group(1)
>      return int(values)
>  
>  
> -def _set_flow_rule_rss(cfg, chan):
> -    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port 9999 action {chan}", host=cfg.remote).stdout
> +def _set_flow_rule_rss(cfg, port, chan):
> +    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} action {chan}", host=cfg.remote).stdout
>      values = re.search(r'ID (\d+)', output).group(1)
>      return int(values)
>  
> @@ -47,22 +47,27 @@ def test_zcrx(cfg) -> None:
>      if combined_chans < 2:
>          raise KsftSkipEx('at least 2 combined channels required')
>      (rx_ring, hds_thresh) = _get_current_settings(cfg)
> +    port = rand_port()
>  
>      ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
>      defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
> +
>      ethtool(f"-G {cfg.ifname} hds-thresh 0", host=cfg.remote)
>      defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}", host=cfg.remote)
> +
>      ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
>      defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
> +
>      ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
>      defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
> -    flow_rule_id = _set_flow_rule(cfg, combined_chans - 1)
> +
> +    flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
>      defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
>  
> -    rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1}"
> -    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 12840"
> +    rx_cmd = f"{cfg.bin_remote} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1}"
> +    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p {port} -l 12840"
>      with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
> -        wait_port_listen(9999, proto="tcp", host=cfg.remote)
> +        wait_port_listen(port, proto="tcp", host=cfg.remote)
>          cmd(tx_cmd)
>  
>  
> @@ -73,22 +78,27 @@ def test_zcrx_oneshot(cfg) -> None:
>      if combined_chans < 2:
>          raise KsftSkipEx('at least 2 combined channels required')
>      (rx_ring, hds_thresh) = _get_current_settings(cfg)
> +    port = rand_port()
>  
>      ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
>      defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
> +
>      ethtool(f"-G {cfg.ifname} hds-thresh 0", host=cfg.remote)
>      defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}", host=cfg.remote)
> +
>      ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
>      defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
> +
>      ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
>      defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
> -    flow_rule_id = _set_flow_rule(cfg, combined_chans - 1)
> +
> +    flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
>      defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
>  
> -    rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1} -o 4"
> -    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 4096 -z 16384"
> +    rx_cmd = f"{cfg.bin_remote} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1} -o 4"
> +    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p {port} -l 4096 -z 16384"
>      with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
> -        wait_port_listen(9999, proto="tcp", host=cfg.remote)
> +        wait_port_listen(port, proto="tcp", host=cfg.remote)
>          cmd(tx_cmd)
>  
>  
> @@ -99,24 +109,28 @@ def test_zcrx_rss(cfg) -> None:
>      if combined_chans < 2:
>          raise KsftSkipEx('at least 2 combined channels required')
>      (rx_ring, hds_thresh) = _get_current_settings(cfg)
> +    port = rand_port()
>  
>      ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
>      defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
> +
>      ethtool(f"-G {cfg.ifname} hds-thresh 0", host=cfg.remote)
>      defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}", host=cfg.remote)
> +
>      ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
>      defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
> +
>      ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
>      defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
>  
>      (ctx_id, delete_ctx) = _create_rss_ctx(cfg, combined_chans)
> -    flow_rule_id = _set_flow_rule_rss(cfg, ctx_id)
> +    flow_rule_id = _set_flow_rule_rss(cfg, port, ctx_id)
>      defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
>  
> -    rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1}"
> -    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 12840"
> +    rx_cmd = f"{cfg.bin_remote} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1}"
> +    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p {port} -l 12840"
>      with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
> -        wait_port_listen(9999, proto="tcp", host=cfg.remote)
> +        wait_port_listen(port, proto="tcp", host=cfg.remote)
>          cmd(tx_cmd)
>  
>  

I think this is fine; my only nit might be that in main, the rand
port could be allocated and passed in via args when ksft_run is
called.

But, I think it probably doesn't matter and it's not worth holding
this up.

Reviewed-by: Joe Damato <jdamato@fastly.com>

