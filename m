Return-Path: <netdev+bounces-152228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 123CF9F3259
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7C516810E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78FB206293;
	Mon, 16 Dec 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCx1mz++"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A0205E2E;
	Mon, 16 Dec 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358232; cv=none; b=mr7Bx0FA4uqFaQRR2L7tG5JElpd2H8IxWb0YimIuDWp6AhN1+0vSV09BrlM6u0T1JHxA381IcObO34SiofpEcqwwNOB/p/+7XLPkmy9H2lJPWvaVbf0kPSgcbkXw7NWJYMNse2Xq0lIGX922xADNf87ppoF1uHOtW86uO4bOe+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358232; c=relaxed/simple;
	bh=uQjOQIpAptRl8pQc8gFSIJEsWRVkI7foqw2nTq56XLE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=EcxvtzKSDp340u8m7eK1+ejOoCAE3jwqZpdRja4ZVXA0YH4yK4NI8u4g5N7hjDxvgCDNL5dsmeoYchPv9v/H9RkgmhhutORa8ShtDV8J/ikjU8KEGIh8Xyp34TsUs8abNDPzb4yu6ZoCxGKaHNXdPOE3bhF7vAFIkSw+Vu/iVCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCx1mz++; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862df95f92so2075782f8f.2;
        Mon, 16 Dec 2024 06:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734358229; x=1734963029; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9dWQe4Es2nwYeY5DBTxwNHhi948NVg8Vto7M75jNwf4=;
        b=UCx1mz++Tc1qNIdmxPmwGW2us5Y4/e1r/1liub9RgetjBWPKoyoqLwmor7qHeiU9Mv
         uMw/mNnzT9zXNEZSGDrYz1Xc2CIfjqAoLKqXKkHUWJc74oUL5McBd37DQFIRlLWx5m5d
         rlY8a4XrE5+kZjS97qdzlratNy148jWzJS+InTNbPcBQYdoIgbFpdeUXjA/5YAn8tbfw
         NbGuDZjgm0imWOLDX0zOxDOT0QyoyvIHYEbXCxItFAyWRqAFKjNJffgX9eNHJunhukXs
         /ggA+uPbApoTVebRsVLkGpQEWJheWHhUomHNfyVp4fVbEqiCHcmTLpfhKM+ICYEDj8pK
         LGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358229; x=1734963029;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dWQe4Es2nwYeY5DBTxwNHhi948NVg8Vto7M75jNwf4=;
        b=Z0kOsqxfltVKRf8LifyDD0CPNJmiHqmYGVzbAWKehzI6bwL2WnraWzc8TyK8poKny0
         oVc3mfmN2XTUsUls0NTux2y5jbbztIUpjq96zKL0TWQCbIzhSv2sP9Oelweahb4sflpn
         QAPashkUxyeonWn/+5zT0pD7CnKyunZjmwpuKPpr6KGVHUNVfOPMCeotWi/YoHoFgLrR
         BLQLbLg6OqIEks5vTEPUNpke4qBn1kFss8umDke+0MXeiv3H9hVZIyc81Q2fd7ShrL+L
         Px/319xe7h9VfYYd/OXxSvbRaQSbJSnFN/2hTexWmlntS6zXd5hZqZQesRuahvvz6Rir
         WCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwJOEkY3zjnSx4ysuzWaXiNMQL83B9BGJ8NyINiuQpQ15Y64vRiHhLG3YCRGK1LVah8h9bcapj@vger.kernel.org, AJvYcCXum0i+K04CHYJe/jwZBK4CxoBAFZF2jSXhBQaPAAp8OKBZ26iuLpCeMzmYX6VhgqHdEa8rqQjqkPztj90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBUB36HPTP9Lf+5vJj4ynTseWLQVOnuddk/CetRMVDJSca9Db
	I+54PsKzyH5XbvlQrpg38U2QIJjyQPj09VhtAzdirZjxxcBO5alfC2Kzwg==
X-Gm-Gg: ASbGncuBK96fXd0/sqeWXD+bYWzajq2tUhKpmmX0W4KW3EuojjMdFahQt3NeWUTsEWp
	4QVUJCyaqZNv4mGT0u1ekXojINvfKffZgS4QFPuqdER66VFtuafG2jjDgFsfIOBxvVBaGyQ8zn1
	gbRQePtAe0JJgHKkOyHxQmFDH7YTiRK7rmcd/6PRVHITjFN+P0eHV0f8o1K/cH8PvKdgrGM3O7l
	2d0K5LQqML+/7GCKHWC9WOzWMOC/me4dUkDn4haymRF0DFXLf1+kqGTZH9csrkk8caPsw==
X-Google-Smtp-Source: AGHT+IGgvauNvh9m+cA+HPEgnrS/JhpusrP9h+F/7ZiTPi1OPkgOAirn6c0/cnunadpKRCcoyowSmA==
X-Received: by 2002:a05:6000:144a:b0:385:f417:ee3d with SMTP id ffacd0b85a97d-38880adb3c3mr9033977f8f.35.1734358228729;
        Mon, 16 Dec 2024 06:10:28 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:3011:496e:7793:8f4c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80602a1sm8225663f8f.97.2024.12.16.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:10:27 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: stfomichev@gmail.com,  kuba@kernel.org,  jdamato@fastly.com,
  pabeni@redhat.com,  davem@davemloft.net,  edumazet@google.com,
  horms@kernel.org,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] tools: ynl: add initial pyproject.toml for
 packaging
In-Reply-To: <2a9b6d5a782acfa71ae5fb2f4d3cc538740013b6.1734345017.git.jstancek@redhat.com>
	(Jan Stancek's message of "Mon, 16 Dec 2024 11:41:42 +0100")
Date: Mon, 16 Dec 2024 13:52:09 +0000
Message-ID: <m2ed2791me.fsf@gmail.com>
References: <cover.1734345017.git.jstancek@redhat.com>
	<2a9b6d5a782acfa71ae5fb2f4d3cc538740013b6.1734345017.git.jstancek@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Stancek <jstancek@redhat.com> writes:

> Signed-off-by: Jan Stancek <jstancek@redhat.com>

nit: missing patch description

> ---
>  tools/net/ynl/pyproject.toml | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 tools/net/ynl/pyproject.toml
>
> diff --git a/tools/net/ynl/pyproject.toml b/tools/net/ynl/pyproject.toml
> new file mode 100644
> index 000000000000..677ea8f4c185
> --- /dev/null
> +++ b/tools/net/ynl/pyproject.toml
> @@ -0,0 +1,26 @@
> +[build-system]
> +requires = ["setuptools>=61.0"]
> +build-backend = "setuptools.build_meta"
> +
> +[project]
> +name = "pyynl"
> +authors = [
> +    {name = "Donald Hunter", email = "donald.hunter@gmail.com"},
> +    {name = "Jakub Kicinski", email = "kuba@kernel.org"},
> +]
> +description = "yaml netlink (ynl)"
> +version = "0.0.1"
> +requires-python = ">=3.9"
> +dependencies = [
> +    "pyyaml==6.*",
> +    "jsonschema==4.*"
> +]
> +
> +[tool.setuptools.packages.find]
> +include = ["pyynl", "pyynl.lib"]
> +
> +[project.scripts]
> +ynl = "pyynl.cli:main"
> +ynl-ethtool = "pyynl.ethtool:main"
> +ynl-gen-c = "pyynl.ynl_gen_c:main"
> +ynl-gen-rst = "pyynl.ynl_gen_rst:main"

I'm not sure if we want to install ynl-gen-c or ynl-gen-rst since they
are for in-tree use.

Thoughts?

