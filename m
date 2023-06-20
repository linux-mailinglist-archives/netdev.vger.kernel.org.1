Return-Path: <netdev+bounces-12302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170737370C4
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490D51C20C86
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718217726;
	Tue, 20 Jun 2023 15:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1017725
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 15:43:45 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF394E72
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 08:43:42 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b47a15ca10so35320841fa.1
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687275819; x=1689867819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7UTWrOAfULzFvcudxUiFOcDaPHTXuwe+AdoZE3lwG30=;
        b=FJbRwh2vrty6+U8dbEE4ZHbhRdRiWRxreYcMW6DSJ97FlQ479S/r2FF0NGO463HG93
         PIBYESkcWq9NtxfiD99rqG0YDaCBCXs9Optnz0B1tRBT8v7kQ6LSQp9tNmmC4Qxcu3I3
         qfyz3R9qvDSAe2KWoYN5GxLCGiZYDB2qHGYW7JAtFX9wyhhf2MyN4Ke9NfZuOL3S77dZ
         X0wsZMwQUBb99EvWQzQ49cqhK435wMW/amXlxTDbkoVkmvsP6K9YYDcXqWd7t7Ptkf27
         MFW6/gb1VbEWPMkiRFapiiWJW80x9b5WqO9JYG78vEBt/KjNi7B1hPPG+T7NlzgvH3e6
         rYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275819; x=1689867819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UTWrOAfULzFvcudxUiFOcDaPHTXuwe+AdoZE3lwG30=;
        b=jtIWoKVhzemvomZsfaASpsHRtiU4dwfIq8NWn2diR1Pvr0sqBkCkw/29FONS9ZkNHB
         h+gRsnQFC13JUAiaO+LLz6zBK78TH628kmdXHzkmiT/0a5a06+fEJH6gPJvuWStKTCVN
         kJ4g4XTrFlzJWOdkrLJRO6YEuxcbMrEkEAw9SNYEYIkWod8XrMz/gursuZ0CvKQs/T8I
         h+iI3s6NXfilGN+6YJAfB/6u1Mi8oHqdVfI2Hdv4O4e8lQRQq1ISBEnXxoNOfmpizygG
         P4pQwSQ9SjHDjbYh/JHS8eHfmPEHZtJIcpsnEotc1jzG83aOWobFSRUzOYkUR1lAAJ5E
         Z4ig==
X-Gm-Message-State: AC+VfDxXstSjpwPxpt/qdSoER6taQJXXj60PKE8LSRbBpSonTgZNRyxn
	lqbauJCJ4CxPCZnz817RFIHu3A==
X-Google-Smtp-Source: ACHHUZ7UuRxTfiKDwpEMUa+KIJ1vCESj9EuLoJU7Qjz6MYsuGdUcMcUMcZkMpMvoeqH28ycLpRx6uQ==
X-Received: by 2002:a2e:b0ef:0:b0:2b3:3180:5d90 with SMTP id h15-20020a2eb0ef000000b002b331805d90mr9420438ljl.22.1687275819094;
        Tue, 20 Jun 2023 08:43:39 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id z6-20020a2e9646000000b002b481369062sm465895ljh.51.2023.06.20.08.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:43:38 -0700 (PDT)
Message-ID: <b56bdd22-7d68-8a48-4207-ca6b83ec2644@linaro.org>
Date: Tue, 20 Jun 2023 17:43:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] bluetooth: qca: add support for WCN7850
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Balakrishna Godavarthi <bgodavar@codeaurora.org>,
 Rocky Liao <rjliao@codeaurora.org>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org>
 <20230620-topic-sm8550-upstream-bt-v1-2-4728564f8872@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v1-2-4728564f8872@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20.06.2023 17:19, Neil Armstrong wrote:
> Add support for the WCN7850 Bluetooth chipset.
> 
> Tested on the SM8550 QRD platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
I don't have comments for this patch specifically, but:


>  drivers/bluetooth/btqca.c   |  7 +++++++
>  drivers/bluetooth/btqca.h   | 10 ++++++++++
>  drivers/bluetooth/hci_qca.c | 48 ++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 54 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index e7e58a956d15..037146b476ff 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -617,6 +617,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	} else if (soc_type == QCA_WCN6855) {
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/hpbtfw%02x.tlv", rom_ver);
> +	} else if (soc_type == QCA_WCN7850) {
> +		snprintf(config.fwname, sizeof(config.fwname),
> +			 "qca/hmtbtfw%02x.tlv", rom_ver);
>  	} else {
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/rampatch_%08x.bin", soc_ver);
> @@ -654,6 +657,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	else if (soc_type == QCA_WCN6855)
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/hpnv%02x.bin", rom_ver);
> +	else if (soc_type == QCA_WCN7850)
> +		snprintf(config.fwname, sizeof(config.fwname),
> +			 "qca/hmtnv%02x.bin", rom_ver);
>  	else
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/nvm_%08x.bin", soc_ver);
The above changes should probably be made switch statements as well

> @@ -695,6 +701,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	case QCA_WCN3991:
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
> +	case QCA_WCN7850:
>  		/* get fw build info */
>  		err = qca_read_fw_build_info(hdev);
>  		if (err < 0)
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index b884095bcd9d..ff1850e984fe 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -148,6 +148,7 @@ enum qca_btsoc_type {
>  	QCA_QCA6390,
>  	QCA_WCN6750,
>  	QCA_WCN6855,
> +	QCA_WCN7850,
>  };
>  
>  #if IS_ENABLED(CONFIG_BT_QCA)
> @@ -173,6 +174,10 @@ static inline bool qca_is_wcn6855(enum qca_btsoc_type soc_type)
>  {
>  	return soc_type == QCA_WCN6855;
>  }
> +static inline bool qca_is_wcn7850(enum qca_btsoc_type soc_type)
> +{
> +	return soc_type == QCA_WCN7850;
> +}
>  
>  #else
>  
> @@ -216,6 +221,11 @@ static inline bool qca_is_wcn6855(enum qca_btsoc_type soc_type)
>  	return false;
>  }
>  
> +static inline bool qca_is_wcn7850(enum qca_btsoc_type soc_type)
> +{
> +	return false;
> +}
> +
>  static inline int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>  {
>  	return -EOPNOTSUPP;
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e30c979535b1..49b8d75d271e 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1322,7 +1322,8 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  	/* Give the controller time to process the request */
>  	if (qca_is_wcn399x(qca_soc_type(hu)) ||
>  	    qca_is_wcn6750(qca_soc_type(hu)) ||
> -	    qca_is_wcn6855(qca_soc_type(hu)))
> +	    qca_is_wcn6855(qca_soc_type(hu)) ||
> +	    qca_is_wcn7850(qca_soc_type(hu)))
>  		usleep_range(1000, 10000);
Separate topic, but I see usages of the helper and raw comparisons
everywhere.. I'd vote for switch everywhere

Konrad
>  	else
>  		msleep(300);
> @@ -1400,7 +1401,8 @@ static int qca_check_speeds(struct hci_uart *hu)
>  {
>  	if (qca_is_wcn399x(qca_soc_type(hu)) ||
>  	    qca_is_wcn6750(qca_soc_type(hu)) ||
> -	    qca_is_wcn6855(qca_soc_type(hu))) {
> +	    qca_is_wcn6855(qca_soc_type(hu)) ||
> +	    qca_is_wcn7850(qca_soc_type(hu))) {
>  		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
>  		    !qca_get_speed(hu, QCA_OPER_SPEED))
>  			return -EINVAL;
> @@ -1435,7 +1437,8 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		 */
>  		if (qca_is_wcn399x(soc_type) ||
>  		    qca_is_wcn6750(soc_type) ||
> -		    qca_is_wcn6855(soc_type))
> +		    qca_is_wcn6855(soc_type) ||
> +		    qca_is_wcn7850(soc_type))
>  			hci_uart_set_flow_control(hu, true);
>  
>  		if (soc_type == QCA_WCN3990) {
> @@ -1454,7 +1457,8 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  error:
>  		if (qca_is_wcn399x(soc_type) ||
>  		    qca_is_wcn6750(soc_type) ||
> -		    qca_is_wcn6855(soc_type))
> +		    qca_is_wcn6855(soc_type) ||
> +		    qca_is_wcn7850(soc_type))
>  			hci_uart_set_flow_control(hu, false);
>  
>  		if (soc_type == QCA_WCN3990) {
> @@ -1691,7 +1695,8 @@ static int qca_power_on(struct hci_dev *hdev)
>  
>  	if (qca_is_wcn399x(soc_type) ||
>  	    qca_is_wcn6750(soc_type) ||
> -	    qca_is_wcn6855(soc_type)) {
> +	    qca_is_wcn6855(soc_type) ||
> +	    qca_is_wcn7850(soc_type)) {
>  		ret = qca_regulator_init(hu);
>  	} else {
>  		qcadev = serdev_device_get_drvdata(hu->serdev);
> @@ -1733,7 +1738,8 @@ static int qca_setup(struct hci_uart *hu)
>  	bt_dev_info(hdev, "setting up %s",
>  		qca_is_wcn399x(soc_type) ? "wcn399x" :
>  		(soc_type == QCA_WCN6750) ? "wcn6750" :
> -		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
> +		(soc_type == QCA_WCN6855) ? "wcn6855" :
> +		(soc_type == QCA_WCN7850) ? "wcn7850" : "ROME/QCA6390");
>  
>  	qca->memdump_state = QCA_MEMDUMP_IDLE;
>  
> @@ -1746,7 +1752,8 @@ static int qca_setup(struct hci_uart *hu)
>  
>  	if (qca_is_wcn399x(soc_type) ||
>  	    qca_is_wcn6750(soc_type) ||
> -	    qca_is_wcn6855(soc_type)) {
> +	    qca_is_wcn6855(soc_type) ||
> +	    qca_is_wcn7850(soc_type)) {
>  		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>  		hci_set_aosp_capable(hdev);
>  
> @@ -1769,7 +1776,8 @@ static int qca_setup(struct hci_uart *hu)
>  
>  	if (!(qca_is_wcn399x(soc_type) ||
>  	      qca_is_wcn6750(soc_type) ||
> -	      qca_is_wcn6855(soc_type))) {
> +	      qca_is_wcn6855(soc_type) ||
> +	      qca_is_wcn7850(soc_type))) {
>  		/* Get QCA version information */
>  		ret = qca_read_soc_version(hdev, &ver, soc_type);
>  		if (ret)
> @@ -1909,6 +1917,20 @@ static const struct qca_device_data qca_soc_data_wcn6855 __maybe_unused = {
>  	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
>  };
>  
> +static const struct qca_device_data qca_soc_data_wcn7850 __maybe_unused = {
> +	.soc_type = QCA_WCN7850,
> +	.vregs = (struct qca_vreg []) {
> +		{ "vddio", 5000 },
> +		{ "vddaon", 26000 },
> +		{ "vdddig", 126000 },
> +		{ "vddrfa0p8", 102000 },
> +		{ "vddrfa1p2", 257000 },
> +		{ "vddrfa1p9", 302000 },
> +	},
> +	.num_vregs = 6,
> +	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
> +};
> +
>  static void qca_power_shutdown(struct hci_uart *hu)
>  {
>  	struct qca_serdev *qcadev;
> @@ -2074,7 +2096,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	if (data &&
>  	    (qca_is_wcn399x(data->soc_type) ||
>  	     qca_is_wcn6750(data->soc_type) ||
> -	     qca_is_wcn6855(data->soc_type))) {
> +	     qca_is_wcn6855(data->soc_type) ||
> +	     qca_is_wcn7850(data->soc_type))) {
>  		qcadev->btsoc_type = data->soc_type;
>  		qcadev->bt_power = devm_kzalloc(&serdev->dev,
>  						sizeof(struct qca_power),
> @@ -2105,7 +2128,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  					       GPIOD_IN);
>  		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
>  		    (data->soc_type == QCA_WCN6750 ||
> -		     data->soc_type == QCA_WCN6855))
> +		     data->soc_type == QCA_WCN6855 ||
> +		     data->soc_type == QCA_WCN7850))
>  			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
>  
>  		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
> @@ -2182,7 +2206,8 @@ static void qca_serdev_remove(struct serdev_device *serdev)
>  
>  	if ((qca_is_wcn399x(qcadev->btsoc_type) ||
>  	     qca_is_wcn6750(qcadev->btsoc_type) ||
> -	     qca_is_wcn6855(qcadev->btsoc_type)) &&
> +	     qca_is_wcn6855(qcadev->btsoc_type) ||
> +	     qca_is_wcn7850(qcadev->btsoc_type)) &&
>  	    power->vregs_on)
>  		qca_power_shutdown(&qcadev->serdev_hu);
>  	else if (qcadev->susclk)
> @@ -2368,6 +2393,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
>  	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
>  	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
>  	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
> +	{ .compatible = "qcom,wcn7850-bt", .data = &qca_soc_data_wcn7850},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
> 

