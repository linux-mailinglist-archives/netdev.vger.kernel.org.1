Return-Path: <netdev+bounces-244956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D1CCC4263
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 17:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 191863102D6A
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CD2357A39;
	Tue, 16 Dec 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ids2ftWF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7535772A
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898058; cv=none; b=JzmlnP5AjqcKRx2nkPTPBaIEzE7ECutGFCcc7NY1An5vfLYQ0+p+25y+dYLmtrxw7278iszK5WSLveOqoAf0tea47yuE9pDKINC0POaM51VurEzJUhcCiKGDubrStc3IxXlTx0MGnRSjQgVblD75XB89hpIb1xSV+PpAGudRAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898058; c=relaxed/simple;
	bh=k8j3mP5If46bGfa9V1k4KZGq39cAyCoVXY4GrLemR6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dleu9l0smsworOnfeDqwjSVF+UYkQN3Qsj42LRWomLLgejaYWN0a4M2A+TiMCafkC8NM12CZwTL3ayhesJdLgU1pk9X7Qmupc9AJ488cCHFmrJjoAR6fzz35FbzpDeLBxy3lFRCBviXIyDEJoEaZtrqXLo1QrgprtvRF/UQhtYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ids2ftWF; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a2d9cf22aso16624921fa.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 07:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765898055; x=1766502855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLiUunvuSO49w9qtKkUdndMt6EKUVeG+KRTk+UHcrJk=;
        b=ids2ftWFzrLSzsBM2g7cmju+ra6Mew7PsVbBPs5yr64ry+zATix4GqkDeSzwHPEtDj
         3Nv4xWCHitqV4miGABdiKh0fdJyWuLT52BfMcXlXT4jV2OXxDmlxjTcH33am9hgCahYS
         pGSsZktfRW6veuy/QSzMCZTe4xsu9lbeZOG5lz5k4xTB1r0EmdpvoQ7EskHgLud2pK/i
         dttSQnmlNgOe74bNL5bT1KWrorLFe9S0KLzlgq9N3teOviHsBrOzrRADCiZKDiFHuDL6
         IgKS3J249P8Xlh8I6wgxsw+rcaf8ZPuaTsAxNrZCxU5xlKEttlQgsTLspGW3CjcFQBNC
         Pu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898055; x=1766502855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLiUunvuSO49w9qtKkUdndMt6EKUVeG+KRTk+UHcrJk=;
        b=vxLvPyN1b1GEIqnk31qEZHgZGIZG8D3vDupWk6RGT/WIqojk+tJmDDRX/ePXmwhJGD
         8ixStX3nXiVQky8JuNDt9DwsW0iEyndDAYR12QwlRLYylpCu/3CGgTXIKZT86hGQk20Y
         zED9F63NdnV05vFLr4g/X0HWkyqqV5ZkKf/J6wtArxHZXou+HuFAkBloijzxYVF2w7XA
         Obu7UPaKBPqevUlKdXtzusJLHoO04+wj/Bl2N4DvxQtaIsI0NG/P5UyMnrTVU6FLeUFR
         n52hQb4iiSGBSV/nfF97D99FfFFkPaIvYnGGzm9SaTqgQkvBBpqACotD4GPfRhY20GYT
         +6yw==
X-Forwarded-Encrypted: i=1; AJvYcCUl3uIgnSWJz6sWTMYZ6nmW3dD2I3SQfkWUzLrPW2o8dRupqDeT4bhn7xvBPwzMsKDi3KKhNhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3U1ge8yf+A9UJlPjWTQ6wp6WbXOG6+nT8J3vLrltXMqjdd47
	yg5tewIF59JxSLsQWNCpZoHWDZrufvaggY2ZaWHSYvoxvPZ566mlMaP6wc4R2C4W1fQNEoBKKWp
	rcIajoXnCMBO/C+HBJuoysZq2U1ikP4c=
X-Gm-Gg: AY/fxX76bE3iZph3yrkO/KzSI8SdgE9t1DsO+yDZcxI8ixNi/E1F7B/1+BsSg912htn
	DlRPD0UMbqIIkxorOj5Ku6sn95aDxj6oH7iziSgIpJrDMv5B5nY6IMXnD3/4aRpaSr/pXaEJ1Ud
	yXYV0iH+zj8ak/Zg36IRC2rcwfGKLitZzlbA6bqJvXvjeg0B7exbJjgKom/clpg1eMsyRAimB5m
	wXzeHz56+NwijKv3UL6Ad4nma/IjVjG+ru9bvDm9Yj0Vo2walN55bs5d7JE4vXSrCKhuA==
X-Google-Smtp-Source: AGHT+IFv6SZ6ayUexa1VdzlGvM3+NN8nkZGP1e3/C6zIpFiwiIh0jo2A0sungYPzoyXZOWE2Mt9yfL2eDBqpOoSlpV4=
X-Received: by 2002:a05:651c:31cf:b0:37f:dde4:c04e with SMTP id
 38308e7fff4ca-37fdde4d469mr38788311fa.3.1765898054514; Tue, 16 Dec 2025
 07:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216113753.3969183-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20251216113753.3969183-1-naga.akella@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Dec 2025 10:14:01 -0500
X-Gm-Features: AQt7F2qVYeGdWnxiMCK_IY1trQu3hfJ1mGDnUb9Iya3GuHJrXKh1Iy-RZQzUNLs
Message-ID: <CABBYNZKXNw3Pi6=5Rx+G3TLWpN2Rkc6iYxiB6QJoTZjMQgMrew@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Initial LE Channel Sounding
 support by defining required HCI command/event structures.
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, anubhavg@qti.qualcomm.com, 
	mohamull@qti.qualcomm.com, hbandi@qti.qualcomm.com, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Tue, Dec 16, 2025 at 6:38=E2=80=AFAM Naga Bhavani Akella
<naga.akella@oss.qualcomm.com> wrote:
>
> 1. Implementing the LE Event Mask to include events required for
>    LE Channel Sounding.
> 2. Enabling the Channel Sounding feature bit in the
>    LE Host Supported Features command.
> 3. Defining HCI command and event structures necessary for
>    LE Channel Sounding functionality.
>
> Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
> ---
>  include/net/bluetooth/hci.h      | 323 +++++++++++++++++++++++++++++++
>  include/net/bluetooth/hci_core.h |   6 +
>  net/bluetooth/hci_sync.c         |  15 ++
>  3 files changed, 344 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index a27cd3626b87..33ec8ddd2119 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -654,6 +654,8 @@ enum {
>  #define HCI_LE_ISO_BROADCASTER         0x40
>  #define HCI_LE_ISO_SYNC_RECEIVER       0x80
>  #define HCI_LE_LL_EXT_FEATURE          0x80
> +#define HCI_LE_CHANNEL_SOUNDING                0x40
> +#define HCI_LE_CHANNEL_SOUNDING_HOST   0x80
>
>  /* Connection modes */
>  #define HCI_CM_ACTIVE  0x0000
> @@ -2269,6 +2271,204 @@ struct hci_cp_le_read_all_remote_features {
>         __u8     pages;
>  } __packed;
>
> +/* Channel Sounding Commands */
> +#define HCI_OP_LE_CS_RD_LOCAL_SUPP_CAP 0x2089
> +struct hci_rp_le_cs_rd_local_supp_cap {
> +       __u8    status;
> +       __u8    num_config_supported;
> +       __le16  max_consecutive_procedures_supported;
> +       __u8    num_antennas_supported;
> +       __u8    max_antenna_paths_supported;
> +       __u8    roles_supported;
> +       __u8    modes_supported;
> +       __u8    rtt_capability;
> +       __u8    rtt_aa_only_n;
> +       __u8    rtt_sounding_n;
> +       __u8    rtt_random_payload_n;
> +       __le16  nadm_sounding_capability;
> +       __le16  nadm_random_capability;
> +       __u8    cs_sync_phys_supported;
> +       __le16  subfeatures_supported;
> +       __le16  t_ip1_times_supported;
> +       __le16  t_ip2_times_supported;
> +       __le16  t_fcs_times_supported;
> +       __le16  t_pm_times_supported;
> +       __u8    t_sw_time_supported;
> +       __u8    tx_snr_capability;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_RD_RMT_SUPP_CAP           0x208A
> +struct hci_cp_le_cs_rd_local_supp_cap {
> +       __le16  conn_hdl;

Id just use handle instead.

> +} __packed;
> +
> +#define HCI_OP_LE_CS_WR_CACHED_RMT_SUPP_CAP    0x208B
> +struct hci_cp_le_cs_wr_cached_rmt_supp_cap {
> +       __le16  conn_hdl;

Ditto.

> +       __u8    num_config_supported;
> +       __le16  max_consecutive_procedures_supported;
> +       __u8    num_antennas_supported;
> +       __u8    max_antenna_paths_supported;
> +       __u8    roles_supported;
> +       __u8    modes_supported;
> +       __u8    rtt_capability;
> +       __u8    rtt_aa_only_n;
> +       __u8    rtt_sounding_n;
> +       __u8    rtt_random_payload_n;
> +       __le16  nadm_sounding_capability;
> +       __le16  nadm_random_capability;
> +       __u8    cs_sync_phys_supported;
> +       __le16  subfeatures_supported;
> +       __le16  t_ip1_times_supported;
> +       __le16  t_ip2_times_supported;
> +       __le16  t_fcs_times_supported;
> +       __le16  t_pm_times_supported;
> +       __u8    t_sw_time_supported;
> +       __u8    tx_snr_capability;
> +} __packed;
> +
> +struct hci_rp_le_cs_wr_cached_rmt_supp_cap {
> +       __u8    status;
> +       __le16  conn_hdl;

Ditto.

> +} __packed;
> +
> +#define HCI_OP_LE_CS_SEC_ENABLE                        0x208C
> +struct hci_cp_le_cs_sec_enable {
> +       __le16  conn_hdl;

Ditto.

> +} __packed;
> +
> +#define HCI_OP_LE_CS_SET_DEFAULT_SETTINGS      0x208D
> +struct hci_cp_le_cs_set_default_settings {
> +       __le16  conn_hdl;

Ditto.

> +       __u8    role_enable;
> +       __u8    cs_sync_ant_sel;
> +       __s8    max_tx_power;
> +} __packed;
> +
> +struct hci_rp_le_cs_set_default_settings {
> +       __u8    status;
> +       __le16  conn_hdl;

Ditto.

> +} __packed;
> +
> +#define HCI_OP_LE_CS_RD_RMT_FAE_TABLE          0x208E
> +struct hci_cp_le_cs_rd_rmt_fae_table {
> +       __le16  conn_hdl;

Ditto.

> +} __packed;
> +
> +#define HCI_OP_LE_CS_WR_CACHED_RMT_FAE_TABLE   0x208F
> +struct hci_cp_le_cs_wr_rmt_cached_fae_table {
> +       __le16  conn_hdl;

Ditto.

> +       __u8    remote_fae_table[72];
> +} __packed;
> +
> +struct hci_rp_le_cs_wr_rmt_cached_fae_table {
> +       __u8    status;
> +       __le16  conn_hdl;

Ditto.

> +} __packed;
> +
> +#define HCI_OP_LE_CS_CREATE_CONFIG             0x2090
> +struct hci_cp_le_cs_create_config {
> +       __le16  conn_hdl;

Ditto.

> +       __u8    config_id;
> +       __u8    create_context;
> +       __u8    main_mode_type;
> +       __u8    sub_mode_type;
> +       __u8    min_main_mode_steps;
> +       __u8    max_main_mode_steps;
> +       __u8    main_mode_repetition;
> +       __u8    mode_0_steps;
> +       __u8    role;
> +       __u8    rtt_type;
> +       __u8    cs_sync_phy;
> +       __u8    channel_map[10];
> +       __u8    channel_map_repetition;
> +       __u8    channel_selection_type;
> +       __u8    ch3c_shape;
> +       __u8    ch3c_jump;
> +       __u8    reserved;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_REMOVE_CONFIG             0x2091
> +struct hci_cp_le_cs_remove_config {
> +       __le16  conn_hdl;

Ditto.

> +       __u8    config_id;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_SET_CH_CLASSIFICATION     0x2092
> +struct hci_cp_le_cs_set_ch_classification {
> +       __u8    ch_classification[10];
> +} __packed;
> +
> +struct hci_rp_le_cs_set_ch_classification {
> +       __u8    status;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_SET_PROC_PARAM            0x2093
> +struct hci_cp_le_cs_set_proc_param {
> +       __le16  conn_hdl;

Ditto.

> +       __u8    config_id;
> +       __le16  max_procedure_len;
> +       __le16  min_procedure_interval;
> +       __le16  max_procedure_interval;
> +       __le16  max_procedure_count;
> +       __u8    min_subevent_len[3];
> +       __u8    max_subevent_len[3];
> +       __u8    tone_antenna_config_selection;
> +       __u8    phy;
> +       __u8    tx_power_delta;
> +       __u8    preferred_peer_antenna;
> +       __u8    snr_control_initiator;
> +       __u8    snr_control_reflector;
> +} __packed;
> +
> +struct hci_rp_le_cs_set_proc_param {
> +       __u8    status;
> +       __le16  conn_hdl;

Ditto.

> +} __packed;
> +
> +#define HCI_OP_LE_CS_SET_PROC_ENABLE           0x2094
> +struct hci_cp_le_cs_set_proc_param {
> +       __le16  conn_hdl;

Ditto.

> +       __u8    config_id;
> +       __u8    enable;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_TEST                      0x2095
> +struct hci_cp_le_cs_test {
> +       __u8    main_mode_type;
> +       __u8    sub_mode_type;
> +       __u8    main_mode_repetition;
> +       __u8    mode_0_steps;
> +       __u8    role;
> +       __u8    rtt_type;
> +       __u8    cs_sync_phy;
> +       __u8    cs_sync_antenna_selection;
> +       __u8    subevent_len[3];
> +       __le16  subevent_interval;
> +       __u8    max_num_subevents;
> +       __u8    transmit_power_level;
> +       __u8    t_ip1_time;
> +       __u8    t_ip2_time;
> +       __u8    t_fcs_time;
> +       __u8    t_pm_time;
> +       __u8    t_sw_time;
> +       __u8    tone_antenna_config_selection;
> +       __u8    reserved;
> +       __u8    snr_control_initiator;
> +       __u8    snr_control_reflector;
> +       __le16  drbg_nonce;
> +       __u8    channel_map_repetition;
> +       __le16  override_config;
> +       __u8    override_parameters_length;
> +       __u8    override_parameters_data[];
> +} __packed;
> +
> +struct hci_rp_le_cs_test {
> +       __u8    status;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_TEST_END                  0x2096
> +
>  /* ---- HCI Events ---- */
>  struct hci_ev_status {
>         __u8    status;
> @@ -2960,6 +3160,129 @@ struct hci_evt_le_read_all_remote_features_comple=
te {
>         __u8    features[248];
>  } __packed;
>
> +/* Channel Sounding Events */
> +#define HCI_EVT_LE_CS_READ_RMT_SUPP_CAP_COMPLETE       0x2C
> +struct hci_evt_le_cs_read_rmt_supp_cap_complete {
> +       __u8    status;
> +       __le16  conn_hdl;

Ditto.

> +       __u8    num_configs_supp;
> +       __le16  max_consec_proc_supp;
> +       __u8    num_ant_supp;
> +       __u8    max_ant_path_supp;
> +       __u8    roles_supp;
> +       __u8    modes_supp;
> +       __u8    rtt_cap;
> +       __u8    rtt_aa_only_n;
> +       __u8    rtt_sounding_n;
> +       __u8    rtt_rand_payload_n;
> +       __le16  nadm_sounding_cap;
> +       __le16  nadm_rand_cap;
> +       __u8    cs_sync_phys_supp;
> +       __le16  sub_feat_supp;
> +       __le16  t_ip1_times_supp;
> +       __le16  t_ip2_times_supp;
> +       __le16  t_fcs_times_supp;
> +       __le16  t_pm_times_supp;
> +       __u8    t_sw_times_supp;
> +       __u8    tx_snr_cap;
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_READ_RMT_FAE_TABLE_COMPLETE      0x2D
> +struct hci_evt_le_cs_read_rmt_fae_table_complete {
> +       __u8    status;
> +       __le16  conn_hdl;
> +       __u8    remote_fae_table[72];
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_SECURITY_ENABLE_COMPLETE         0x2E
> +struct hci_evt_le_cs_security_enable_complete {
> +       __u8    status;
> +       __le16  conn_hdl;

Ditto.

> +} __packed;
> +
> +#define HCI_EVT_LE_CS_CONFIG_COMPLETE                  0x2F
> +struct hci_evt_le_cs_config_complete {
> +       __u8    status;
> +       __le16  conn_hdl;

Ditto.

> +       __u8    config_id;
> +       __u8    action;
> +       __u8    main_mode_type;
> +       __u8    sub_mode_type;
> +       __u8    min_main_mode_steps;
> +       __u8    max_main_mode_steps;
> +       __u8    main_mode_rep;
> +       __u8    mode_0_steps;
> +       __u8    role;
> +       __u8    rtt_type;
> +       __u8    cs_sync_phy;
> +       __u8    channel_map[10];
> +       __u8    channel_map_rep;
> +       __u8    channel_sel_type;
> +       __u8    ch3c_shape;
> +       __u8    ch3c_jump;
> +       __u8    reserved;
> +       __u8    t_ip1_time;
> +       __u8    t_ip2_time;
> +       __u8    t_fcs_time;
> +       __u8    t_pm_time;
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_PROCEDURE_ENABLE_COMPLETE                0x30
> +struct hci_evt_le_cs_procedure_enable_complete {
> +       __u8    status;
> +       __le16  conn_hdl;

Ditto.

> +       __u8    config_id;
> +       __u8    state;
> +       __u8    tone_ant_config_sel;
> +       __s8    sel_tx_pwr;
> +       __u8    sub_evt_len[3];
> +       __u8    sub_evts_per_evt;
> +       __le16  sub_evt_intrvl;
> +       __le16  evt_intrvl;
> +       __le16  proc_intrvl;
> +       __le16  proc_counter;
> +       __le16  max_proc_len;
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_SUBEVENT_RESULT                  0x31
> +struct hci_evt_le_cs_subevent_result {
> +       __le16  conn_hdl;

Ditto.

> +       __u8    config_id;
> +       __le16  start_acl_conn_evt_counter;
> +       __le16  proc_counter;
> +       __le16  freq_comp;
> +       __u8    ref_pwr_lvl;
> +       __u8    proc_done_status;
> +       __u8    subevt_done_status;
> +       __u8    abort_reason;
> +       __u8    num_ant_paths;
> +       __u8    num_steps_reported;
> +       __u8    step_mode[0]; /* depends on num_steps_reported */
> +       __u8    step_channel[0]; /* depends on num_steps_reported */
> +       __u8    step_data_length[0]; /* depends on num_steps_reported */
> +       __u8    step_data[0]; /* depends on num_steps_reported */
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE         0x32
> +struct hci_evt_le_cs_subevent_result_continue {
> +       __le16  conn_hdl;

Ditto.

> +       __u8    config_id;
> +       __u8    proc_done_status;
> +       __u8    subevt_done_status;
> +       __u8    abort_reason;
> +       __u8    num_ant_paths;
> +       __u8    num_steps_reported;
> +       __u8    step_mode[0]; /* depends on num_steps_reported */
> +       __u8    step_channel[0]; /* depends on num_steps_reported */
> +       __u8    step_data_length[0]; /* depends on num_steps_reported */
> +       __u8    step_data[0]; /* depends on num_steps_reported */
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_TEST_END_COMPLETE                        0x33
> +struct hci_evt_le_cs_test_end_complete {
> +       __u8    status;
> +} __packed;
> +
>  #define HCI_EV_VENDOR                  0xff
>
>  /* Internal events generated by Bluetooth stack */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 4263e71a23ef..0152299a00b9 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -2071,6 +2071,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>  #define ll_ext_feature_capable(dev) \
>         ((dev)->le_features[7] & HCI_LE_LL_EXT_FEATURE)
>
> +/* Channel sounding support */
> +#define chann_sounding_capable(dev) \
> +       (((dev)->le_features[5] & HCI_LE_CHANNEL_SOUNDING))
> +#define chann_sounding_host_capable(dev) \
> +       (((dev)->le_features[5] & HCI_LE_CHANNEL_SOUNDING_HOST))

Just use sc_ instead of chann_sounding.

> +
>  #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) =
&& \
>         (!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index a9f5b1a68356..67b2c55ec043 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4427,6 +4427,17 @@ static int hci_le_set_event_mask_sync(struct hci_d=
ev *hdev)
>                 events[4] |=3D 0x02;      /* LE BIG Info Advertising Repo=
rt */
>         }
>
> +       if (chann_sounding_capable(hdev)) {
> +               /* Channel Sounding events */
> +               events[5] |=3D 0x08;      /* LE CS Read Remote Supported =
Cap Complete event */
> +               events[5] |=3D 0x10;      /* LE CS Read Remote FAE Table =
Complete event */
> +               events[5] |=3D 0x20;      /* LE CS Security Enable Comple=
te event */
> +               events[5] |=3D 0x40;      /* LE CS Config Complete event =
*/
> +               events[5] |=3D 0x80;      /* LE CS Procedure Enable Compl=
ete event */
> +               events[6] |=3D 0x01;      /* LE CS Subevent Result event =
*/
> +               events[6] |=3D 0x02;      /* LE CS Subevent Result Contin=
ue event */
> +               events[6] |=3D 0x04;      /* LE CS Test End Complete even=
t */
> +       }
>         return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EVENT_MASK,
>                                      sizeof(events), events, HCI_CMD_TIME=
OUT);
>  }
> @@ -4572,6 +4583,10 @@ static int hci_le_set_host_feature_sync(struct hci=
_dev *hdev)
>         cp.bit_number =3D 32;
>         cp.bit_value =3D iso_enabled(hdev) ? 0x01 : 0x00;
>
> +       /* Channel Sounding (Host Support) */
> +       cp.bit_number =3D 47;
> +       cp.bit_value =3D chann_sounding_capable(hdev) ? 0x01 : 0x00;
> +
>         return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
>                                      sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>  }
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum=
,
> a Linux Foundation Collaborative Project
>


--=20
Luiz Augusto von Dentz

