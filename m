Return-Path: <netdev+bounces-50932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBC97F78FE
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 17:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA091C20919
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5E428DBA;
	Fri, 24 Nov 2023 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpW2GhNg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046235F0D;
	Fri, 24 Nov 2023 16:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCD0C433C7;
	Fri, 24 Nov 2023 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700843460;
	bh=0m2/cMBcTydjmRWM2kg9Xg3sXuhlmH0zFa0ospNDRBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpW2GhNg4EblHnxfauyUbT06NCJY/KQePisvrxpj3Bb0hqiZ9OQAqj2ZX10vIPnm/
	 7fV725jNxjWCkDAK8WFoBG2ZCuoLURtPDbWYV97BoU1PL61sGBZ/Npasvffl+In+Bo
	 53GGEWDwJjZVJFpoiPVZv99XLTZtb9VXFJATxD5/+ufBGwCkrH8PJOnUYqsXWHvwEQ
	 aOjF8HzHhMyBjUAosqaZ+rK96Mif55NMadoGV/ppGVZfcd/VN/XVDEMQdulju5PSGu
	 9/Mmq2SqYGQpY1LOEM4kFJaw1p6TBIUSEgQv7RpwNNv1Vkw1BzUGU5D362A/BvomHp
	 7v/HdYqIjRx3Q==
Date: Fri, 24 Nov 2023 16:30:54 +0000
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231124163054.GQ50352@kernel.org>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>

On Thu, Nov 16, 2023 at 03:01:41PM +0100, Kory Maincent wrote:
> Add a new driver for the PD692x0 I2C Power Sourcing Equipment controller.
> This driver only support i2c communication for now.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Hi Kory,

some minor feedback from my side.

...

> diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c

...

> +static int
> +pd692x0_get_of_matrix(struct device *dev,
> +		      struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS])
> +{
> +	int ret, i, ports_matrix_size;
> +	u32 val[PD692X0_MAX_LOGICAL_PORTS * 3];

nit: reverse xmas tree please.

...

> +static int pd692x0_fw_write_line(const struct i2c_client *client,
> +				 const char line[PD692X0_FW_LINE_MAX_SZ],
> +				 const bool last_line)
> +{
> +	int ret;
> +
> +	while (*line != 0) {
> +		ret = i2c_master_send(client, line, 1);
> +		if (ret < 0)
> +			return FW_UPLOAD_ERR_RW_ERROR;
> +		line++;
> +	}
> +
> +	if (last_line) {
> +		ret = pd692x0_fw_recv_resp(client, 100, "TP\r\n",
> +					   sizeof("TP\r\n") - 1);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = pd692x0_fw_recv_resp(client, 100, "T*\r\n",
> +					   sizeof("T*\r\n") - 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}

...

> +static enum fw_upload_err pd692x0_fw_write(struct fw_upload *fwl,
> +					   const u8 *data, u32 offset,
> +					   u32 size, u32 *written)
> +{
> +	struct pd692x0_priv *priv = fwl->dd_handle;
> +	char line[PD692X0_FW_LINE_MAX_SZ];
> +	const struct i2c_client *client;
> +	int ret, i;
> +	char cmd;
> +
> +	client = priv->client;
> +	priv->fw_state = PD692X0_FW_WRITE;
> +
> +	/* Erase */
> +	cmd = 'E';
> +	ret = i2c_master_send(client, &cmd, 1);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to boot programming mode (%pe)\n",
> +			ERR_PTR(ret));
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	}
> +
> +	ret = pd692x0_fw_recv_resp(client, 100, "TOE\r\n", sizeof("TOE\r\n") - 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = pd692x0_fw_recv_resp(client, 5000, "TE\r\n", sizeof("TE\r\n") - 1);
> +	if (ret)
> +		dev_warn(&client->dev,
> +			 "Failed to erase internal memory, however still try to write Firmware\n");
> +
> +	ret = pd692x0_fw_recv_resp(client, 100, "TPE\r\n", sizeof("TPE\r\n") - 1);
> +	if (ret)
> +		dev_warn(&client->dev,
> +			 "Failed to erase internal memory, however still try to write Firmware\n");
> +
> +	if (priv->cancel_request)
> +		return FW_UPLOAD_ERR_CANCELED;
> +
> +	/* Program */
> +	cmd = 'P';
> +	ret = i2c_master_send(client, &cmd, sizeof(char));
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to boot programming mode (%pe)\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret = pd692x0_fw_recv_resp(client, 100, "TOP\r\n", sizeof("TOP\r\n") - 1);
> +	if (ret)
> +		return ret;
> +
> +	i = 0;
> +	while (i < size) {
> +		ret = pd692x0_fw_get_next_line(data, line, size - i);
> +		if (!ret) {
> +			ret = FW_UPLOAD_ERR_FW_INVALID;
> +			goto err;
> +		}
> +
> +		i += ret;
> +		data += ret;
> +		if (line[0] == 'S' && line[1] == '0') {
> +			continue;
> +		} else if (line[0] == 'S' && line[1] == '7') {
> +			ret = pd692x0_fw_write_line(client, line, true);
> +			if (ret)
> +				goto err;
> +		} else {
> +			ret = pd692x0_fw_write_line(client, line, false);
> +			if (ret)
> +				goto err;
> +		}
> +
> +		if (priv->cancel_request) {
> +			ret = FW_UPLOAD_ERR_CANCELED;
> +			goto err;
> +		}
> +	}
> +	*written = i;
> +
> +	msleep(400);
> +
> +	return FW_UPLOAD_ERR_NONE;
> +
> +err:
> +	pd692x0_fw_write_line(client, "S7\r\n", true);

gcc-13 (W=1) seems a bit upset about this.

 drivers/net/pse-pd/pd692x0.c: In function 'pd692x0_fw_write':
 drivers/net/pse-pd/pd692x0.c:861:9: warning: 'pd692x0_fw_write_line' reading 128 bytes from a region of size 5 [-Wstringop-overread]
   861 |         pd692x0_fw_write_line(client, "S7\r\n", true);
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/net/pse-pd/pd692x0.c:861:9: note: referencing argument 2 of type 'const char[128]'
 drivers/net/pse-pd/pd692x0.c:642:12: note: in a call to function 'pd692x0_fw_write_line'
   642 | static int pd692x0_fw_write_line(const struct i2c_client *client,
       |            ^~~~~~~~~~~~~~~~~~~~~

> +	return ret;
> +}

...

