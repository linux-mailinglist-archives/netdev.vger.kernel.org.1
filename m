Return-Path: <netdev+bounces-21345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D0A7635A1
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7776C1C21237
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01469BA20;
	Wed, 26 Jul 2023 11:51:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21CBE5E
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:51:17 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8524FA0
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 04:50:56 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1988561E5FE01;
	Wed, 26 Jul 2023 13:40:46 +0200 (CEST)
Message-ID: <bcb7cf39-2051-c874-ca98-e96d849b8b55@molgen.mpg.de>
Date: Wed, 26 Jul 2023 13:40:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: VLAN untagged traffic
 support
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20230726105054.295220-1-wojciech.drewek@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230726105054.295220-1-wojciech.drewek@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear Wojciech,


Thank you for your patch.

Could you use a statement as summary by using a verb (in imperative 
mood)? Maybe:

Support untagged VLAN traffic

Am 26.07.23 um 12:50 schrieb Wojciech Drewek:
> When driver recives SWITCHDEV_FDB_ADD_TO_DEVICE notification

receives

> with vid = 1, it means that we have to offload untagged traffic.
> This is achieved by adding vlan metadata lookup.
> 
> Also remove unnecessary brackets in ice_eswitch_br_fdb_entry_create.

For things starting with “Also” in the git commit message, that’s a good 
indicator for a separate commit. ;-)

> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_eswitch_br.c | 9 +++++----
>   drivers/net/ethernet/intel/ice/ice_eswitch_br.h | 9 ---------
>   2 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> index 67bfd1f61cdd..05bee706b946 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> @@ -104,13 +104,15 @@ ice_eswitch_br_rule_delete(struct ice_hw *hw, struct ice_rule_query_data *rule)
>   static u16
>   ice_eswitch_br_get_lkups_cnt(u16 vid)
>   {
> -	return ice_eswitch_br_is_vid_valid(vid) ? 2 : 1;
> +	return vid == 0 ? 1 : 2;

Should some comment be added to the function to explain the behavior?

>   }
>   
>   static void
>   ice_eswitch_br_add_vlan_lkup(struct ice_adv_lkup_elem *list, u16 vid)
>   {
> -	if (ice_eswitch_br_is_vid_valid(vid)) {
> +	if (vid == 1) {
> +		ice_rule_add_vlan_metadata(&list[1]);
> +	} else if (vid > 1) {

Why is vid == 1 treated differently from the others?


Kind regards,

Paul


>   		list[1].type = ICE_VLAN_OFOS;
>   		list[1].h_u.vlan_hdr.vlan = cpu_to_be16(vid & VLAN_VID_MASK);
>   		list[1].m_u.vlan_hdr.vlan = cpu_to_be16(0xFFFF);
> @@ -400,11 +402,10 @@ ice_eswitch_br_fdb_entry_create(struct net_device *netdev,
>   	unsigned long event;
>   	int err;
>   
> -	/* untagged filtering is not yet supported */
>   	if (!(bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING) && vid)
>   		return;
>   
> -	if ((bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING)) {
> +	if (bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING) {
>   		vlan = ice_esw_br_port_vlan_lookup(bridge, br_port->vsi_idx,
>   						   vid);
>   		if (IS_ERR(vlan)) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> index 85a8fadb2928..cf7b0e5acfcb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> @@ -103,15 +103,6 @@ struct ice_esw_br_vlan {
>   		     struct ice_esw_br_fdb_work, \
>   		     work)
>   
> -static inline bool ice_eswitch_br_is_vid_valid(u16 vid)
> -{
> -	/* In trunk VLAN mode, for untagged traffic the bridge sends requests
> -	 * to offload VLAN 1 with pvid and untagged flags set. Since these
> -	 * flags are not supported, add a MAC filter instead.
> -	 */
> -	return vid > 1;
> -}
> -
>   void
>   ice_eswitch_br_offloads_deinit(struct ice_pf *pf);
>   int

