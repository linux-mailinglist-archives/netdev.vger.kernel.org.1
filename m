Return-Path: <netdev+bounces-190250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB4AB5D6E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA081B6136B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31882BF990;
	Tue, 13 May 2025 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ii84YzWu"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E4C28F514
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747166024; cv=none; b=A93RJhGbSwW/W3JW2J+95rR6u2uarNYfMITJfNFgSGgwf5rHTPXCF/BDN7Tbba2vOhJub4dQHyVSp2er+PMxIEZnZVPTSE5oU382JpBhoHNG56TyO0XgJOKv5FojkgOxuHb82y9AQ6wOwU0fnrEZYrXGeKI2poxHBge736FGYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747166024; c=relaxed/simple;
	bh=jMpC6+nTKGYxh9FKwRMUXnHVG/DDLVXrGxDoqwaLuBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7+Y2FlfTrfSAUPtPR5bxMD15KLFYAVHehhT5nK4rB4s9B1tzWx6W13I8X594VAAyp8r8efbwOjg4SLBt52vZA3hwC84hxmlMKDpCcHRVhKrpvnokunumsE8YDPmrNuixZZy0P0czw7l7fFJzpe7IJ7fVeEpdK7BMmHQwmsq4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ii84YzWu; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4ef4472b-62a5-43f6-bd16-d6e0ace2335a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747166020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYP7x1zvO/0xeI6ty3KByabRtirdkevOlW1UhJHVsvg=;
	b=Ii84YzWuLnEvAwapfSdu42QhvO5nByoj0vYOwk0+wRWbcWfXuVQsG155uOXWQBqmECPgUb
	OCs7zEqoHuCrFEGw6lBxcWh9WS/LUzJcQyzhbj5flMURVa2xi6LguZuVmyqnWR7638FJdC
	4gjm4stZu9r71q7Bw1qQpnROYum+5oQ=
Date: Tue, 13 May 2025 20:53:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] ptp: ocp: Limit signal/freq counts in show/store
 functions
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250511154235.101780-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250511154235.101780-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11.05.2025 16:42, Sagi Maimon wrote:
> The sysfs show/store operations could access uninitialized elements
> in the freq_in[] and signal_out[] arrays, leading to NULL pointer
> dereferences. This patch introduces u8 fields (nr_freq_in,
> nr_signal_out) to track the number of initialized elements, capping
> the maximum at 4 for each array. The show/store functions are updated
> to respect these limits, preventing out-of-bounds access and ensuring
> safe array handling.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> Addressed comments from Vadim Fedorenko:
>   - https://www.spinics.net/lists/netdev/msg1090730.html
> Changes since v3:
>   - in signal/freq show routine put constant string "UNSUPPORTED" in
>     output instead of returning error.
> ---
> ---
>   drivers/ptp/ptp_ocp.c | 40 +++++++++++++++++++++++++++++++++-------
>   1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 2ccdca4f6960..14b4b3bebccd 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -315,6 +315,8 @@ struct ptp_ocp_serial_port {
>   #define OCP_BOARD_ID_LEN		13
>   #define OCP_SERIAL_LEN			6
>   #define OCP_SMA_NUM			4
> +#define OCP_SIGNAL_NUM			4
> +#define OCP_FREQ_NUM			4
>   
>   enum {
>   	PORT_GNSS,
> @@ -342,8 +344,8 @@ struct ptp_ocp {
>   	struct dcf_master_reg	__iomem *dcf_out;
>   	struct dcf_slave_reg	__iomem *dcf_in;
>   	struct tod_reg		__iomem *nmea_out;
> -	struct frequency_reg	__iomem *freq_in[4];
> -	struct ptp_ocp_ext_src	*signal_out[4];
> +	struct frequency_reg	__iomem *freq_in[OCP_FREQ_NUM];
> +	struct ptp_ocp_ext_src	*signal_out[OCP_SIGNAL_NUM];
>   	struct ptp_ocp_ext_src	*pps;
>   	struct ptp_ocp_ext_src	*ts0;
>   	struct ptp_ocp_ext_src	*ts1;
> @@ -378,10 +380,12 @@ struct ptp_ocp {
>   	u32			utc_tai_offset;
>   	u32			ts_window_adjust;
>   	u64			fw_cap;
> -	struct ptp_ocp_signal	signal[4];
> +	struct ptp_ocp_signal	signal[OCP_SIGNAL_NUM];
>   	struct ptp_ocp_sma_connector sma[OCP_SMA_NUM];
>   	const struct ocp_sma_op *sma_op;
>   	struct dpll_device *dpll;
> +	int signals_nr;
> +	int freq_in_nr;
>   };
>   
>   #define OCP_REQ_TIMESTAMP	BIT(0)
> @@ -2697,6 +2701,8 @@ ptp_ocp_fb_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>   	bp->eeprom_map = fb_eeprom_map;
>   	bp->fw_version = ioread32(&bp->image->version);
>   	bp->sma_op = &ocp_fb_sma_op;
> +	bp->signals_nr = 4;
> +	bp->freq_in_nr = 4;
>   
>   	ptp_ocp_fb_set_version(bp);
>   
> @@ -2862,6 +2868,8 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>   	bp->fw_version = ioread32(&bp->reg->version);
>   	bp->fw_tag = 2;
>   	bp->sma_op = &ocp_art_sma_op;
> +	bp->signals_nr = 4;
> +	bp->freq_in_nr = 4;
>   
>   	/* Enable MAC serial port during initialisation */
>   	iowrite32(1, &bp->board_config->mro50_serial_activate);
> @@ -2888,6 +2896,8 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>   	bp->flash_start = 0xA00000;
>   	bp->eeprom_map = fb_eeprom_map;
>   	bp->sma_op = &ocp_adva_sma_op;
> +	bp->signals_nr = 2;
> +	bp->freq_in_nr = 2;
>   
>   	version = ioread32(&bp->image->version);
>   	/* if lower 16 bits are empty, this is the fw loader. */
> @@ -3190,6 +3200,9 @@ signal_store(struct device *dev, struct device_attribute *attr,
>   	if (!argv)
>   		return -ENOMEM;
>   
> +	if (gen >= bp->signals_nr)
> +		return -EINVAL;
> +
>   	err = -EINVAL;
>   	s.duty = bp->signal[gen].duty;
>   	s.phase = bp->signal[gen].phase;
> @@ -3247,6 +3260,10 @@ signal_show(struct device *dev, struct device_attribute *attr, char *buf)
>   	int i;
>   
>   	i = (uintptr_t)ea->var;
> +
> +	if (i >= bp->signals_nr)
> +		return sysfs_emit(buf, "UNSUPPORTED\n");
> +
>   	signal = &bp->signal[i];

I've checked the code again. Jakub is right, there is no need to modify
singal/seconds/frequency show/set functions. Now I'm not quite sure how is it
possible to reach this functions with unsupported input? You export a specific
set of attributes for your card:

static const struct ocp_attr_group adva_timecard_groups[] = {
	{ .cap = OCP_CAP_BASIC,	    .group = &adva_timecard_group },
	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq0_group },
	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq1_group },
	{ },
};

It has only freq1, freq2, gen1, gen2 attributes exported to sysfs. How can it
happen that you can change freq3 or gen3?

The only problem I see is in the summary output - that should be addressed with
this patch (well, you've done it already).

>   
>   	count = sysfs_emit(buf, "%llu %d %llu %d", signal->period,
> @@ -3359,6 +3376,9 @@ seconds_store(struct device *dev, struct device_attribute *attr,
>   	u32 val;
>   	int err;
>   
> +	if (idx >= bp->freq_in_nr)
> +		return -EINVAL;
> +
>   	err = kstrtou32(buf, 0, &val);
>   	if (err)
>   		return err;
> @@ -3381,6 +3401,9 @@ seconds_show(struct device *dev, struct device_attribute *attr, char *buf)
>   	int idx = (uintptr_t)ea->var;
>   	u32 val;
>   
> +	if (idx >= bp->freq_in_nr)
> +		return sysfs_emit(buf, "UNSUPPORTED\n");
> +
>   	val = ioread32(&bp->freq_in[idx]->ctrl);
>   	if (val & 1)
>   		val = (val >> 8) & 0xff;
> @@ -3402,6 +3425,9 @@ frequency_show(struct device *dev, struct device_attribute *attr, char *buf)
>   	int idx = (uintptr_t)ea->var;
>   	u32 val;
>   
> +	if (idx >= bp->freq_in_nr)
> +		return -EINVAL;
> +
>   	val = ioread32(&bp->freq_in[idx]->status);
>   	if (val & FREQ_STATUS_ERROR)
>   		return sysfs_emit(buf, "error\n");
> @@ -4008,7 +4034,7 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
>   {
>   	struct signal_reg __iomem *reg = bp->signal_out[nr]->mem;
>   	struct ptp_ocp_signal *signal = &bp->signal[nr];
> -	char label[8];
> +	char label[16];
>   	bool on;
>   	u32 val;
>   
> @@ -4031,7 +4057,7 @@ static void
>   _frequency_summary_show(struct seq_file *s, int nr,
>   			struct frequency_reg __iomem *reg)
>   {
> -	char label[8];
> +	char label[16];
>   	bool on;
>   	u32 val;
>   
> @@ -4175,11 +4201,11 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
>   	}
>   
>   	if (bp->fw_cap & OCP_CAP_SIGNAL)
> -		for (i = 0; i < 4; i++)
> +		for (i = 0; i < bp->signals_nr; i++)
>   			_signal_summary_show(s, bp, i);
>   
>   	if (bp->fw_cap & OCP_CAP_FREQ)
> -		for (i = 0; i < 4; i++)
> +		for (i = 0; i < bp->freq_in_nr; i++)
>   			_frequency_summary_show(s, i, bp->freq_in[i]);
>   
>   	if (bp->irig_out) {

---
pw-bot:cr

