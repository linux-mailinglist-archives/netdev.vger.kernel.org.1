Return-Path: <netdev+bounces-187408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA79AA7001
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 12:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46841B678F4
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A12417C5;
	Fri,  2 May 2025 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOQTL4NP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F31EA7F1
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182728; cv=none; b=d8vZYe3UKaK72aiTnwIgOGKnl1oj7/6Vl8yepAUxOIw2CGHIlIKKzYY2mtwcXLBXeqH/m/hY+5M8TJk3DBB++WU+UFY7IzNTSyyympB6b4imc8sSieBYwlYvN2gJuMSNc9oluU0VALYOWgWVO91RikLY51HCkOEPruREBA7Q8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182728; c=relaxed/simple;
	bh=R7VQRMq4PIP0s92+13UFSy/4rGH3IdBE+W1fWIYEuSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKGfZuWZlm9qIFAJTGx1ZQp+WmJ2yb76CVEE7D7MmZ6h6cUQ4uyQGoJ0HSQovCTiMDMJ7dqYNjjGKUHA6KTezObC8LNmZ2ccL+wxPXxrOplDJBrTTPBl88ZtjwDk03hhgAibAk6Lx97xkv0hPHjQBXpLPT1HQDIzM5JfGSXi0go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOQTL4NP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497FAC4CEE4;
	Fri,  2 May 2025 10:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746182727;
	bh=R7VQRMq4PIP0s92+13UFSy/4rGH3IdBE+W1fWIYEuSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOQTL4NPjmg/ukxTqn8MlBL1O0CmLz9QOYea4l0ZfbYXYQrg5waujBRG+T6VXbA7L
	 8gA5YRgZxIIVLQTqtXz3EfbMfCNWOlHnllPliMjyolw0R6U7yfLhEOJkbYDUmsrGUJ
	 zFgYAMImma+Mrk6VwYhzwryOKTmJ4Sau1jGE4omy4Njwalz+bHTilWTvtN0OMCE2JZ
	 5TQep1XGFgmdtHh+XxXE2iFuU4IkNyUQNbbiJAe4deTffV9xb24QENNnoHB8KyRNYx
	 radKP33ULcmyAKDBLAAEEmPFKBlwzC5ICjrVXDjTUZ2ZT4LE+RUlxUuCzeyK8agSbu
	 toNpZVeNdkvWQ==
Date: Fri, 2 May 2025 11:45:23 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [net PATCH 5/6] fbnic: Cleanup handling of completions
Message-ID: <20250502104523.GH3339421@horms.kernel.org>
References: <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
 <174614222289.126317.15583861344398410489.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174614222289.126317.15583861344398410489.stgit@ahduyck-xeon-server.home.arpa>

On Thu, May 01, 2025 at 04:30:22PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> There was an issue in that if we were to shutdown we could be left with
> a completion in flight as the mailbox went away. To address that I have
> added an fbnic_mbx_evict_all_cmpl function that is meant to essentially
> create a "broken pipe" type response so that all callers will receive an
> error indicating that the connection has been broken as a result of us
> shutting down the mailbox.
> 
> In addition the naming was inconsistent between the creation and clearing
> of completions. Since the cmpl seems to be the common suffix to use for the
> handling of cmpl_data I went through and renamed fbnic_fw_clear_compl to
> fbnic_fw_clear_cmpl.

I do see this is somehow related to the fix described in the first
paragraph. But I don't think renaming functions like this is appropriate
for net.

> Fixes: 378e5cc1c6c6 ("eth: fbnic: hwmon: Add completion infrastructure for firmware requests")
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |   22 +++++++++++++++++++++-
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |    2 +-
>  drivers/net/ethernet/meta/fbnic/fbnic_mac.c |    2 +-
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index d019191d6ae9..efc0176f1a9a 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -928,6 +928,23 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
>  	return attempts ? 0 : -ETIMEDOUT;
>  }
>  
> +static void __fbnic_fw_evict_cmpl(struct fbnic_fw_completion *cmpl_data)
> +{
> +	cmpl_data->result = -EPIPE;
> +	complete(&cmpl_data->done);
> +}
> +
> +static void fbnic_mbx_evict_all_cmpl(struct fbnic_dev *fbd)
> +{
> +	struct fbnic_fw_completion *cmpl_data;
> +
> +	cmpl_data = fbd->cmpl_data;
> +	if (cmpl_data)
> +		__fbnic_fw_evict_cmpl(cmpl_data);
> +
> +	memset(&fbd->cmpl_data, 0, sizeof(fbd->cmpl_data));

Maybe I've been staring at my screen for too long, but could this
be expressed more succinctly as:

	fbd->cmpl_data = NULL;

And if so, it seems that step can be skipped if cmpl_data is already
NULL, which is already checked.

Leading to the following, which is somehow easier on my brain.

static void fbnic_mbx_evict_all_cmpl(struct fbnic_dev *fbd)
{
	if (fbd->cmpl_data) {
		__fbnic_fw_evict_cmpl(fbd->cmpl_data);
		fbd->cmpl_data = NULL;
	}
}

> +}
> +
>  void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
>  {
>  	unsigned long timeout = jiffies + 10 * HZ + 1;
> @@ -945,6 +962,9 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
>  	/* Read tail to determine the last tail state for the ring */
>  	tail = tx_mbx->tail;
>  
> +	/* Flush any completions as we are no longer processing Rx */
> +	fbnic_mbx_evict_all_cmpl(fbd);
> +
>  	spin_unlock_irq(&fbd->fw_tx_lock);
>  
>  	/* Give firmware time to process packet,
> @@ -983,7 +1003,7 @@ void fbnic_fw_init_cmpl(struct fbnic_fw_completion *fw_cmpl,
>  	kref_init(&fw_cmpl->ref_count);
>  }
>  
> -void fbnic_fw_clear_compl(struct fbnic_dev *fbd)
> +void fbnic_fw_clear_cmpl(struct fbnic_dev *fbd)
>  {
>  	unsigned long flags;
>  
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> index a3618e7826c2..2d5e0ff1982c 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> @@ -69,7 +69,7 @@ int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
>  				 struct fbnic_fw_completion *cmpl_data);
>  void fbnic_fw_init_cmpl(struct fbnic_fw_completion *cmpl_data,
>  			u32 msg_type);
> -void fbnic_fw_clear_compl(struct fbnic_dev *fbd);
> +void fbnic_fw_clear_cmpl(struct fbnic_dev *fbd);
>  void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);
>  
>  #define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str, _str_sz) \
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> index dde4a37116e2..7e54f82535f6 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> @@ -744,7 +744,7 @@ static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id,
>  
>  	*val = *sensor;
>  exit_cleanup:
> -	fbnic_fw_clear_compl(fbd);
> +	fbnic_fw_clear_cmpl(fbd);
>  exit_free:
>  	fbnic_fw_put_cmpl(fw_cmpl);
>  
> 
> 
> 

