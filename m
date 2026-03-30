Return-Path: <netdev+bounces-273101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Kz1GfA8ymnG6wUAu9opvQ
	(envelope-from <netdev+bounces-273101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:05:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C08357C31
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B4AB307EBE5
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39813ACF12;
	Mon, 30 Mar 2026 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UV4rLANJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215CD3ACF16
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860623; cv=none; b=gpD24uIzkpgdFAPxEHoLM8jL7l2mvGrS/zRNJIopbZnJrk6sHGG+FWuVIGnzxAS1rSVuXMntO8j1vmlpfi8t+fcTxeaDXYpCuWowjGUyHL+HH/sHkwdV9nf4GIstkRfmDry8vBWvQdtUEMS28mmH1GKjUakUXUHxvmkcilJT92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860623; c=relaxed/simple;
	bh=2KoPNxmKsdxT6zmm+q+ltTKBWlpbtb6RIHYy4EaLfYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0Vobfj2dJvc4rs2gak2M0ZLSlYfO9lxj/PFtuVV0gzGrLkR46bwvyoeQOY29LT+FUo0e6BBIWprV9HF/4+3WPKBSmz7spKnzN7qBaUZnamtvr8yZDADKnFjhenGFLQAzdHdhNgJ4JtX1+dIyKcWVlxaLO7JOO0WgsBKUlqDwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UV4rLANJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774860621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCaX9vVMAeysC0r5VvECqBNsRE2DjxzmEaovdyRV5VM=;
	b=UV4rLANJdm6A7KWpCCmUeaWl0sVGYQR46qJjQkvfnB+RCOZqHDqBG0cTQi1Y1hhOmq11sC
	IlVqrrMdT7pVzGuSqou/qX0+eOT8qK5kDbLIsbcbRsKUigZb5lSsBeBQS0CfCpGaTmpKSU
	RLem1oZ2HRBcWFlyYC6DvxJBglYK1lc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-_WBNSPxmOLqeOsmKJIe0MQ-1; Mon,
 30 Mar 2026 04:50:17 -0400
X-MC-Unique: _WBNSPxmOLqeOsmKJIe0MQ-1
X-Mimecast-MFC-AGG-ID: _WBNSPxmOLqeOsmKJIe0MQ_1774860616
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6359918002C7;
	Mon, 30 Mar 2026 08:50:16 +0000 (UTC)
Received: from [10.44.33.70] (unknown [10.44.33.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6758130001A1;
	Mon, 30 Mar 2026 08:50:15 +0000 (UTC)
Message-ID: <e0488c57-5745-4398-b646-9f791e14c20a@redhat.com>
Date: Mon, 30 Mar 2026 10:50:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2] dpll: Send object per event in JSON
 monitor mode
To: Vitaly Grinberg <vgrinber@redhat.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org
References: <20260329-dpll-mon-j-v2-1-c8170a80e6d8@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260329-dpll-mon-j-v2-1-c8170a80e6d8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273101-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5C08357C31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/29/26 9:51 AM, Vitaly Grinberg wrote:
> Previously, monitor mode wrapped all events in a single JSON array
> inside a top-level object, which made piping the output to external
> tools (such as `jq`) impossible.
> Send a separate JSON object for each event in monitor mode,
> making the output suitable for line-by-line consumers. Skip the
> global JSON wrapper for monitor mode.
> 
> Signed-off-by: Vitaly Grinberg <vgrinber@redhat.com>
> ---
> v2:
>    - Fixed indentation
> ---
>   dpll/dpll.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/dpll/dpll.c b/dpll/dpll.c
> index 9893ca8c..49576d23 100644
> --- a/dpll/dpll.c
> +++ b/dpll/dpll.c
> @@ -571,8 +571,15 @@ int main(int argc, char **argv)
>   	argc -= optind;
>   	argv += optind;
>   
> -	new_json_obj_plain(json);
> -	open_json_object(NULL);
> +	/* Monitor emits one JSON object per event for streaming;
> +	 * other commands use a single JSON wrapper object.
> +	 */
> +	bool is_monitor = argc > 0 && strcmp(argv[0], "monitor") == 0;
> +
> +	if (!is_monitor) {
> +		new_json_obj_plain(json);
> +		open_json_object(NULL);
> +	}
>   
>   	/* Skip netlink init for help commands */
>   	bool need_nl = true;
> @@ -602,8 +609,10 @@ dpll_fini:
>   	if (need_nl)
>   		dpll_fini(dpll);
>   json_cleanup:
> -	close_json_object();
> -	delete_json_obj_plain();
> +	if (!is_monitor) {
> +		close_json_object();
> +		delete_json_obj_plain();
> +	}
>   dpll_free:
>   	dpll_free(dpll);
>   	return ret;
> @@ -2173,6 +2182,7 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
>   
>   		mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_cb, tb);
>   
> +		new_json_obj_plain(json);
>   		open_json_object(NULL);
>   		print_string(PRINT_JSON, "name", NULL, json_name);
>   		open_json_object("msg");
> @@ -2182,6 +2192,7 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
>   
>   		close_json_object();
>   		close_json_object();
> +		delete_json_obj_plain();
>   		break;
>   	}
>   	case DPLL_CMD_PIN_CREATE_NTF:
> @@ -2200,6 +2211,7 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
>   			json_name = "pin-delete-ntf";
>   		}
>   
> +		new_json_obj_plain(json);
>   		open_json_object(NULL);
>   		print_string(PRINT_JSON, "name", NULL, json_name);
>   		open_json_object("msg");
> @@ -2209,6 +2221,7 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
>   
>   		close_json_object();
>   		close_json_object();
> +		delete_json_obj_plain();
>   		break;
>   	}
>   	default:
> @@ -2273,8 +2286,6 @@ static int cmd_monitor(struct dpll *dpll)
>   		goto err_signalfd;
>   	}
>   
> -	open_json_array(PRINT_JSON, "monitor");
> -
>   	pfds[0].fd = signal_fd;
>   	pfds[0].events = POLLIN;
>   	pfds[1].fd = netlink_fd;
> @@ -2307,8 +2318,6 @@ static int cmd_monitor(struct dpll *dpll)
>   		}
>   	}
>   
> -	close_json_array(PRINT_JSON, NULL);
> -
>   err_signalfd:
>   	if (signal_fd >= 0)
>   		close(signal_fd);
> 
> ---
> base-commit: 36252727bfc653905bb39bec115a32869452beb1
> change-id: 20260328-dpll-mon-j-d88eb48c1f09
> 
> Best regards,
> --
> Vitaly Grinberg <vgrinber@redhat.com>
> 
> 
Thanks Vitaly... next time please do not forget to CC me and Petr.

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


