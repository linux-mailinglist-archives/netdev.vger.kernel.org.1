Return-Path: <netdev+bounces-137829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCF89A9FC7
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 12:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1598283D1E
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5457B198E7E;
	Tue, 22 Oct 2024 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TB6eGUtm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592291957FC
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592278; cv=none; b=L/QPnl0CaZipqr0S2ZSeROmF9esFR1d0abspaZPewy9D0BESr3LEAPkjeR7VZ0m5M0+1FqEPzV8g2e5H5xWR8NJdxcAu06+nYfKgkh0ems8r32+lziCHu9NHLPqm+hmSogkDqjAQ0adENEJlnyVM6e57o0kLiyQovGAHFr+OdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592278; c=relaxed/simple;
	bh=F7fYLHf1F0ibUk3B9Dlg8qjLYPMjBGsNz+cA6zjGjew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcFpTyGcNFvqJ+63PPn2xQIBK6ncfmFayDytKKWAFDfmt55rpHQABCVkpb7OoKyTmE21wkEgNd8UdLFq4EmQjGgYRD/gp5tLBc3jTbuAptwrh26jiIUmymrhIBMkwye0Z4DO/8n8FKfCN+sFM7KTADJAUISkzkyL+D6prBCqBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TB6eGUtm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729592275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afEMX6hvhF+bEuSBXuy4vMwiJ/UEHN0+5JysSySMVE0=;
	b=TB6eGUtm5LFNK5xLSTUB3IcQs5ReAtECdhUtsgbX1sLJmQVjWWPEeMA3p7wgRrwSjZLyVW
	N6PoKH2qPXfZl6xeRaqVIN1cO0H+739TvE66ETS0Yle9CMiYngyXiJ8W6MW7pUV41T8Jpy
	C0+EXid17eNHrRtnphYitZyz/U/HhO8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-ZrrGind9NJKA7TDT2VHzAQ-1; Tue, 22 Oct 2024 06:17:53 -0400
X-MC-Unique: ZrrGind9NJKA7TDT2VHzAQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43157cff1d1so43664675e9.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 03:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729592272; x=1730197072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afEMX6hvhF+bEuSBXuy4vMwiJ/UEHN0+5JysSySMVE0=;
        b=oh/ZkOFA3kTDNukXYW+Tkd+L0+0iuEy4lOGghCka/wEw59TiuXtQcefPducLAImqH+
         aFRfxrqGY9n9D10+NdNw6ctK8LWobQhSm+xDwhRjumjpU0nDzxz59HHr+cnQfgCQJioq
         HEtJz2XwC0yJQOD0v143FRcWCA8hnhhcOcOkYOCNMvHlbOLfKMG8bV7tIHG+EdcpRdPw
         pbisGaEVJSJ1/rg0sDwkt4rbRazoAvQCMmmqWm+f9sKO848R55LYrA1TESuxEjkLP3+d
         DuhCzZ5wFwDWxK1+Ln3eiYAGhcz6LJniwViYDavW8exsuWM4pvM9hWQ89ZSzcdpja/ZP
         UsFw==
X-Forwarded-Encrypted: i=1; AJvYcCWiGqOPCIgFwiPOVCq+/K+F2SC2iaPuL/Ky0BEglWLyU250nl49qUvaWPB6x6pg3o1I/Dgr1Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzROUzadl3GhDmIHs2WoK5MRTeG5YO8zzmH5ZpAfSbRi9fOgADA
	CG7iK4m8p/vS5bbISlHbSpPmnbe4mrfSYrVvO3WUCjkSgT2bvcOpFzVbenajPbtZ6dSH73+6iSP
	k7MsJM/keer/oazr2NbxIwDT0FBMQ6Ey+US6ZOg8czdKmkRZNRN72Uw==
X-Received: by 2002:a05:600c:3b07:b0:426:61e8:fb3b with SMTP id 5b1f17b1804b1-4317caf6bd7mr14830585e9.27.1729592272375;
        Tue, 22 Oct 2024 03:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHPXMmPoqqnTUIWtOfsOzji8AphQjUnwdrJKcXlc99EyaDOrkLUeeqnDFzrVNdeOKdUaR+9g==
X-Received: by 2002:a05:600c:3b07:b0:426:61e8:fb3b with SMTP id 5b1f17b1804b1-4317caf6bd7mr14830285e9.27.1729592271864;
        Tue, 22 Oct 2024 03:17:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8? ([2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a47b74sm6268704f8f.27.2024.10.22.03.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 03:17:51 -0700 (PDT)
Message-ID: <c1890a67-6cc5-4f37-bc33-5fd49b6839c5@redhat.com>
Date: Tue, 22 Oct 2024 12:17:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] selftests: nic_link_layer: Add link layer
 selftest for NIC driver
To: Mohan Prasad J <mohan.prasad@microchip.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch
Cc: edumazet@google.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, horms@kernel.org, brett.creeley@amd.com,
 rosenp@gmail.com, UNGLinuxDriver@microchip.com, willemb@google.com,
 petrm@nvidia.com
References: <20241016215014.401476-1-mohan.prasad@microchip.com>
 <20241016215014.401476-2-mohan.prasad@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241016215014.401476-2-mohan.prasad@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/16/24 23:50, Mohan Prasad J wrote:
> Add selftest file for the link layer tests of a NIC driver.
> Test for auto-negotiation is added.
> Add LinkConfig class for changing link layer configs.
> Selftest makes use of ksft modules and ethtool.
> Include selftest file in the Makefile.
> 
> Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../drivers/net/hw/lib/py/__init__.py         |   1 +
>  .../drivers/net/hw/lib/py/linkconfig.py       | 220 ++++++++++++++++++
>  .../drivers/net/hw/nic_link_layer.py          |  84 +++++++
>  4 files changed, 306 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
>  create mode 100644 tools/testing/selftests/drivers/net/hw/nic_link_layer.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index c9f2f48fc..0dac40c4e 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -10,6 +10,7 @@ TEST_PROGS = \
>  	hw_stats_l3.sh \
>  	hw_stats_l3_gre.sh \
>  	loopback.sh \
> +	nic_link_layer.py \
>  	pp_alloc_fail.py \
>  	rss_ctx.py \
>  	#
> diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> index b58288578..399789a96 100644
> --- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> +++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> @@ -9,6 +9,7 @@ try:
>      sys.path.append(KSFT_DIR.as_posix())
>      from net.lib.py import *
>      from drivers.net.lib.py import *
> +    from .linkconfig import LinkConfig
>  except ModuleNotFoundError as e:
>      ksft_pr("Failed importing `net` library from kernel sources")
>      ksft_pr(str(e))
> diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py b/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
> new file mode 100644
> index 000000000..86cbf10a3
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
> @@ -0,0 +1,220 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import cmd
> +from lib.py import ethtool
> +from lib.py import ksft_pr, ksft_eq
> +import re
> +import time
> +import json
> +
> +#The LinkConfig class is implemented to handle the link layer configurations.
> +#Required minimum ethtool version is 6.10
> +#The ethtool and ip would require authentication to make changes, so better
> +# to check them for sudo privileges for interruption free testing.
> +
> +class LinkConfig:
> +    """Class for handling the link layer configurations"""
> +    def __init__(self, cfg):
> +        self.cfg = cfg
> +        self.partner_netif = self.get_partner_netif_name()
> +
> +        """Get the initial link configuration of local interface"""
> +        self.common_link_modes = self.get_common_link_modes()
> +
> +    def get_partner_netif_name(self):

You should use type hints for both the arguments and the return type.

> +        partner_netif = None
> +        try:
> +            """Get partner interface name"""
> +            partner_cmd = f"ip -o -f inet addr show | grep '{self.cfg.remote_addr}' " + "| awk '{print $2}'"

It's better if you use json output even here

[...]
> +    def reset_interface(self, local=True, remote=True):
> +        ksft_pr("Resetting interfaces in local and remote")
> +        if remote:
> +            if self.partner_netif is not None:
> +                ifname = self.partner_netif
> +                link_up_cmd = f"sudo ip link set up {ifname}"
> +                link_down_cmd = f"sudo ip link set down {ifname}"
> +                reset_cmd = f"{link_down_cmd} && sleep 5 && {link_up_cmd}"
> +                try:
> +                    cmd(f"{reset_cmd}", host=self.cfg.remote)
> +                except Exception as e:
> +                    ksft_pr("Check sudo permission for ip command")
> +                    ksft_pr(f"Unexpected error occurred: {e}")

Please, don't use sudo, just run the command directly. The selftests
should be executed only by privileged users.

[...]
> +    def check_autoneg_supported(self, remote=False):
> +        if remote==False:
> +            local_autoneg = self.get_ethtool_field("supports-auto-negotiation")
> +            if local_autoneg is None:
> +                ksft_pr(f"Unable to fetch auto-negotiation status for interface {self.cfg.ifname}")
> +            """Return autoneg status of the local interface"""
> +            status = True if local_autoneg == True else False
> +            return status

Out of sheer ignorance, in't

		return local_autoneg

enough?


> +        else:
> +            """Check remote auto-negotiation support status"""
> +            partner_autoneg = False
> +            if self.partner_netif is not None:
> +                partner_autoneg = self.get_ethtool_field("supports-auto-negotiation", remote=True)
> +                if partner_autoneg is None:
> +                    ksft_pr(f"Unable to fetch auto-negotiation status for interface {partner_netif}")
> +            status = True if partner_autoneg is True else False
> +            return status
> +
> +    def get_common_link_modes(self):
> +        common_link_modes = None
> +        """Populate common link modes"""
> +        link_modes = self.get_ethtool_field("supported-link-modes")
> +        partner_link_modes = self.get_ethtool_field("link-partner-advertised-link-modes")
> +        if link_modes is None:
> +            raise Exception(f"Link modes not available for {self.cfg.ifname}")
> +        if partner_link_modes is None:
> +            raise Exception(f"Partner link modes not available for {self.cfg.ifname}")
> +        common_link_modes = set(link_modes) and set(partner_link_modes)
> +        return common_link_modes
> +
> +    def get_speed_duplex_values(self, link_modes):
> +        speed = []
> +        duplex = []
> +        """Check the link modes"""
> +        for data in link_modes:
> +            parts = data.split('/')
> +            speed_value = re.match(r'\d+', parts[0])
> +            if speed_value:
> +                speed.append(speed_value.group())
> +            else:
> +                ksft_pr(f"No speed value found for interface {self.ifname}")
> +                return None, None
> +            duplex.append(parts[1].lower())
> +        return speed, duplex
> +
> +    def get_ethtool_field(self, field: str, remote=False):
> +        process = None
> +        if remote == False:
> +            """Get the ethtool field value for the local interface"""
> +            ifname = self.cfg.ifname
> +            try:
> +                process = ethtool(f"--json {ifname}")
> +            except Exception as e:
> +                ksft_pr("Required minimum ethtool version is 6.10")
> +                ksft_pr(f"Unexpected error occurred: {e}")
> +        else:
> +            """Get the ethtool field value for the remote interface"""
> +            remote = True
> +            ifname = self.partner_netif
> +            self.cfg.require_cmd("ethtool", remote)
> +            command = f"ethtool --json {ifname}"
> +            try:
> +                process = cmd(command, host=self.cfg.remote)
> +            except Exception as e:
> +                ksft_pr("Required minimum ethtool version is 6.10")
> +                ksft_pr("Unexpected error occurred: {e}")
> +        if process is None or process.ret != 0:
> +            print(f"Error while getting the ethtool content for interface {ifname}. Required minimum ethtool version is 6.10")
> +            return None
> +        output = json.loads(process.stdout)
> +        json_data = output[0]
> +        """Check if the field exist in the json data"""
> +        if field not in json_data:
> +            raise Exception(f"Field {field} does not exist in the output of interface {json_data["ifname"]}")
> +            return None
> +        return json_data[field]
> diff --git a/tools/testing/selftests/drivers/net/hw/nic_link_layer.py b/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
> new file mode 100644
> index 000000000..fb046efbe
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/nic_link_layer.py
> @@ -0,0 +1,84 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +#Introduction:
> +#This file has basic link layer tests for generic NIC drivers.
> +#The test comprises of auto-negotiation, speed and duplex checks.
> +#
> +#Setup:
> +#Connect the DUT PC with NIC card to partner pc back via ethernet medium of your choice(RJ45, T1)
> +#
> +#        DUT PC                                              Partner PC
> +#┌───────────────────────┐                         ┌──────────────────────────┐
> +#│                       │                         │                          │
> +#│                       │                         │                          │
> +#│           ┌───────────┐                         │                          │
> +#│           │DUT NIC    │         Eth             │                          │
> +#│           │Interface ─┼─────────────────────────┼─    any eth Interface    │
> +#│           └───────────┘                         │                          │
> +#│                       │                         │                          │
> +#│                       │                         │                          │
> +#└───────────────────────┘                         └──────────────────────────┘
> +#
> +#Configurations:
> +#To prevent interruptions, Add ethtool, ip to the sudoers list in remote PC and get the ssh key from remote.
> +#Required minimum ethtool version is 6.10
> +#Change the below configuration based on your hw needs.
> +# """Default values"""
> +time_delay = 8 #time taken to wait for transitions to happen, in seconds.
> +test_duration = 10  #performance test duration for the throughput check, in seconds.

It would be probably useful to allow the user overriding the above
values via env variables and/or command line arguments.

'test_duration' declaration should probably moved to a later patch,
where it's used.

Thanks,

Paolo


